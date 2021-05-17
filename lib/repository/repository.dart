import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoriaInfo_response.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/models/branchOffice.dart';
import 'package:prueba3_git/models/branchOffice_response.dart';
import 'package:prueba3_git/models/chart.dart';
import 'package:prueba3_git/models/chart_response.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_info.dart';
import 'package:prueba3_git/models/product_info_response.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/models/user_response.dart';
import 'package:prueba3_git/screens/login_screen.dart';

final String urlBase = 'http://192.168.0.15:45455/laplayacapacitacion/api/';

String usuarioJson;
User unUsuario = new User();
String token;
String idSucursal = '';
String idDeposito = '';
ProductInfo unProductoPrecio = new ProductInfo();

void _logout(context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => LoginScreen()), (r) => false);
}

//Se llama desde Login1Screen, logea un usuario
Future<User> postLogin(BuildContext context, String nombre, String password,
    String idDevice) async {
  final String webServiceUrl = 'account/login';

  Map<String, String> header = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  http.Response respuesta;
  Map data = {'username': nombre, 'password': password, 'idDevice': idDevice};
  var body = json.encode(data);

  try {
    respuesta =
        await http.post(urlBase + webServiceUrl, headers: header, body: body);
  } on Exception {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("ERROR"),
              content: new Text("Usuario no valido"),
              actions: <Widget>[
                //Prueba cambio de boton
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    _logout(context);
                  },
                )
              ],
            ));
  }

  final String respuestaString = respuesta.body;
  usuarioJson = respuestaString;
  unUsuario = userFromJson(respuestaString);
  token = unUsuario.token;
  return unUsuario;
}

Future<User> postLoginConGoogle(
    BuildContext context, String nombre, String idDevice) async {
  final String webServiceUrl = 'account/loginWithGoogleAccount';

  Map<String, String> header = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  http.Response respuesta;
  Map data = {'username': nombre, 'idDevice': idDevice};
  var body = json.encode(data);

  try {
    respuesta =
        await http.post(urlBase + webServiceUrl, headers: header, body: body);
  } on Exception {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("ERROR"),
              content: new Text("Usuario no valido"),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    _logout(context);
                  },
                )
              ],
            ));
  }

  final String respuestaString = respuesta.body;
  usuarioJson = respuestaString;
  unUsuario = userFromJson(respuestaString);
  token = unUsuario.token;
  return unUsuario;
}

class Repository {
  //DESPUES LO SACO DE ACÁ
  void guardarIdentificacionSucursalDeposito(idS, idD) {
    idSucursal = idS;
    idDeposito = idD;
  }

  final Dio _dio = Dio();

  //////////////////////////////////////////////////////////////////////////////
  ///////////////METODOS GET PARA OBTENCION DE DATOS ///////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  //Devuelve un usuario
  Future<UserResponse> getUser() async {
    try {
      UserResponse userResponse =
          new UserResponse(userFromJson(usuarioJson), "");
      return userResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  //Devuelve una lista de sucursales con sus respectivos depositos
  Future<BranchOfficeResponse> getBranchOfficeList(idUsuario) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(
          urlBase + "branchoffice/GetSucursal?id=$idUsuario",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      BranchOfficeResponse branchOfficeResponse =
          new BranchOfficeResponse(branchOfficeFromJson(x), "");
      return branchOfficeResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BranchOfficeResponse.withError("$error");
    }
  }

  //Devuelve una lista de todas las auditorias de gondola
  Future<AuditoriaResponse> getAuditoriaRackList() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(urlBase + "audit/GetAllAuditsRack",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      AuditoriaResponse auditoriaResponse =
          new AuditoriaResponse(auditoriaFromJson(x), "");
      return auditoriaResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AuditoriaResponse.withError("$error");
    }
  }

  //Devuelve una lista de todas las auditorias de stock
  Future<AuditoriaResponse> getAuditoriaStockList() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(urlBase + "audit/GetAllAuditsStock",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      AuditoriaResponse auditoriaResponse =
          new AuditoriaResponse(auditoriaFromJson(x), "");
      print(auditoriaFromJson(x));
      return auditoriaResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AuditoriaResponse.withError("$error");
    }
  }

  //Devuelve el detalle de una sola auditoria, especificando el ID
  Future<AuditoriaInfoResponse> getAuditRackByID(idValue) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(
          urlBase + "audit/GetAuditRackByID?id=$idValue",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      AuditoriaInfoResponse auditoriaResponse =
          new AuditoriaInfoResponse(auditoriaInfoFromJson(x), "");
      return auditoriaResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AuditoriaInfoResponse.withError("$error");
    }
  }

  //Devuelve un producto en especifico con el ID proporcionado
  Future<ProductInfoResponse> getProduct(idValue) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio.get(
          urlBase + "products/GetProductInfo?id=$idValue",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      print(x);
      ProductInfoResponse productInfoResponse =
          new ProductInfoResponse(productInfoFromJson(x), "");
      return productInfoResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductInfoResponse.withError("$error");
    }
  }

  //Devuelve una lista de productos filtrados depende lo que especifique el usuario
  Future<ProductResponse> getProductList(hint, begin, end) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio
          .get(urlBase + "products/GetList?text=$hint&begin=$begin&end=$end");
      String x = json.encode(response.data);
      ProductResponse productResponse =
          new ProductResponse(productFromJson(x), "");
      return productResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  //Devuelve el precio de un producto especificando su ID
  Future<ProductInfo> preciosProductos(idProduct) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio.get(
          urlBase + "products/GetProductInfo?id=$idProduct",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      print(x);
      // ignore: unused_local_variable
      unProductoPrecio = productInfoFromJson(x);
      return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<String> getStatusRegister(BuildContext context, User usuario) async {
    String token = usuario.token;
    final String webServiceUrl = 'Account/StatusRegister';
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };
    var respuesta;

    try {
      respuesta = await http.get(urlBase + webServiceUrl, headers: header);
    } on Exception {
      return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("ERROR"),
                content: new Text("La aplicacion debe cerrarse"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      _logout(context);
                    },
                  )
                ],
              ));
    }

    return respuesta.body;
  }

  Future<ReasonResponse> getReasons() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(urlBase + "Audit/getReasons",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      ReasonResponse razones = new ReasonResponse(reasonFromJson(x), "");
      return razones;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ReasonResponse.withError("$error");
    }
  }

  Future<ChartResponse> getChartsByCode(codigo) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(
          urlBase + "charts/GraficoCasosCampania?codigoConsulta=$codigo",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      ChartResponse chartResponse = new ChartResponse(chartFromJson(x), "");
      return chartResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ChartResponse.withError("$error");
    }
  }

  Future<PerfilResponse> getCharts() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await _dio.get(urlBase + "charts/getConsultaDePerfil",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      PerfilResponse perfilResponse = new PerfilResponse(perfilFromJson(x), "");
      return perfilResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PerfilResponse.withError("$error");
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  ///////////////METODOS POST PARA SUBIDA DE DE DATOS //////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  //Realiza un post de la auditoria, recibe la lista de productos y un string que le especifica las observaciones
  void postNuevaAuditoriaStock(List<Item> listaItems, codeDialog) {
    String webServiceUrl = 'Audit/NewAuditStock';

    Auditoria unaAuditoria = new Auditoria();
    unaAuditoria.items = [];
    unaAuditoria.branchOfficeId = idSucursal;
    unaAuditoria.depositId = idDeposito;
    unaAuditoria.observations = codeDialog;

    listaItems.forEach((item) {
      unaAuditoria.items.add(item);
      item.reasons = [];
    });

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };

    http.post(urlBase + webServiceUrl,
        headers: header, body: auditoriaToJson(unaAuditoria));

    print(auditoriaToJson(unaAuditoria));
  }

  //Realiza un post de la auditoria de gondola, recibe la lista de productos y un string que le especifica las observaciones
  void postNuevaAuditoriaGondola(List<Item> listaItems, codeDialog) {
    String webServiceUrl = 'Audit/NewAuditStockRack';

    Auditoria unaAuditoria = new Auditoria();
    unaAuditoria.items = [];
    unaAuditoria.branchOfficeId = idSucursal;
    unaAuditoria.depositId = idDeposito;
    unaAuditoria.observations = codeDialog;

    listaItems.forEach((item) {
      unaAuditoria.items.add(item);
    });

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };

    http.post(urlBase + webServiceUrl,
        headers: header, body: auditoriaToJson(unaAuditoria));

    print(auditoriaToJson(unaAuditoria));
  }
}

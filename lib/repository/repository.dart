import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
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
  //final String webServiceUrl = 'account/login';
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
                //Prueba cambio de boton
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    _logout(context);
                    //Navigator.of(context).pop();
                    // exit(1);
                  },
                )
              ],
            ));
  }

  final String respuestaString = respuesta.body;
  //unUsuario = respuestaString;
  return userFromJson(respuestaString);
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
                    //Navigator.of(context).pop();
                    // exit(1);
                  },
                )
              ],
            ));
  }

  return respuesta.body;
}

class Repository {
  final Dio _dio = Dio();

  //Despues sacar el token de acá
  // String token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNpcyIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL3N1YnNjcmlwdG9yIjoibGFwbGF5YWNhcGFjaXRhY2lvbiIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL2lkdXN1YXJpbyI6IjIiLCJyb2xlIjoiMTExIiwiaHR0cDovL3NjaGVtYXMuZ3lhLmNvbS9pZGVudGl0eS9jbGFpbXMvY29kaWdvc3VjdXJzYWwiOiIxIiwibmJmIjoxNjA5OTU2MzU4LCJleHAiOjE2MTEyNTIzNTgsImlhdCI6MTYwOTk1NjM1OCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0OTIyMCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDkyMjAifQ.HK_e5YLdhBrEqwt3F07EmehtiAc84aauW30EBA7PQjE';

  //////////////////////////////////////////////////////////////////////////////
  ///////////////METODOS GET PARA OBTENCION DE DATOS ///////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Future<UserResponse> getUser() async {
    // try {
    //   Response response = await _dio.get(
    //       "https://run.mocky.io/v3/26eb94e0-1ae5-427d-97d9-6db3b117156b",
    //       options: Options(responseType: ResponseType.json));
    //   String x = json.encode(response.data);
    //   UserResponse userResponse = new UserResponse(userFromJson(unUsuario), "");
    //   return userResponse;
    // } catch (error, stacktrace) {
    //   print("Exception occured: $error stackTrace: $stacktrace");
    //   return UserResponse.withError("$error");
    // }

    try {
      UserResponse userResponse =
          new UserResponse(userFromJson(usuarioJson), "");
      return userResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  //Devuelve una lista de todas las auditorias
  Future<AuditoriaResponse> getAuditoriaList() async {
    try {
      Response response = await _dio.get(
          "https://run.mocky.io/v3/06fc7f65-bcf6-4e39-a91a-347e16e87e82",
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

  //Devuelve un producto en especifico con el ID proporcionado
  Future<ProductInfoResponse> getProduct(idValue) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio.get(
          urlBase + "products/GetProductInfo?id=$idValue",
          options: Options(responseType: ResponseType.json));
      String x = "[" + json.encode(response.data) + "]";
      print(x);
      ProductInfoResponse productInfoResponse =
          new ProductInfoResponse(productInfoFromJson(x), "");
      return productInfoResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductInfoResponse.withError("$error");
    }
  }

  // Future<ProductInfoResponse> getExistenciasArticulo(idValue) async {
  //   _dio.options.headers['content-Type'] = 'application/json';
  //   _dio.options.headers["authorization"] = "Bearer $token";

  //   try {
  //     Response response = await _dio.get(
  //         urlBase + "products/GetExistenciasArticulo?id=$idValue",
  //         options: Options(responseType: ResponseType.json));
  //     String x = "[" + json.encode(response.data) + "]";
  //     print(x);
  //     ProductInfoResponse productInfoResponse =
  //         new ProductInfoResponse(productInfoFromJson(x), "");
  //     return productInfoResponse;
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return ProductInfoResponse.withError("$error");
  //   }
  // }

  //Devuelve una lista de productos filtrados depende lo que especifique el usuario
  Future<ProductResponse> getProductList(hint) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $token";

    try {
      Response response = await _dio
          .get(urlBase + "products/GetList?text=" + hint + "&begin=0&end=10");
      String x = json.encode(response.data);
      ProductResponse productResponse =
          new ProductResponse(productFromJson(x), "");
      return productResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  //https://run.mocky.io/v3/9ad1f7f6-f2e1-43d8-a3b8-f507f5d0cf1b
  Future<ProductResponse> getProductosFake() async {
    try {
      Response response = await _dio.get(
          "https://run.mocky.io/v3/9ad1f7f6-f2e1-43d8-a3b8-f507f5d0cf1b",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      ProductResponse productResponse =
          new ProductResponse(productFromJson(x), "");
      return productResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  ///////////////METODOS POST PARA SUBIDA DE DE DATOS //////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  void postNuevaAuditoria(listaProductos, codeDialog) {
    String webServiceUrl = 'Audit/NewAuditStock';

    Auditoria unaAuditoria = new Auditoria();
    unaAuditoria.branchOfficeId = 1;
    unaAuditoria.depositId = 2;
    unaAuditoria.observations = codeDialog;

    int index = 0;
    while (index < listaProductos.length) {
      Item unItem = new Item();
      unItem.productId = listaProductos[index].id;
      unItem.presentationId = listaProductos[index].prices[0].presentation;
      if (unaAuditoria.items == null) {
        unaAuditoria.items = new List<Item>();
      }
      if (unItem.reasons == null) {
        unItem.reasons = new List<Reason>();
      }
      unaAuditoria.items.add(unItem);
      index++;
    }

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };

    http.post(urlBase + webServiceUrl,
        headers: header, body: auditoriaToJson(unaAuditoria));

    print(auditoriaToJson(unaAuditoria));
  }

  void postNuevaAuditoriaStock(listaProductos, codeDialog) {
    String webServiceUrl = 'Audit/NewAuditStockRack';

    Auditoria unaAuditoria = new Auditoria();
    unaAuditoria.branchOfficeId = 1;
    unaAuditoria.depositId = 2;
    unaAuditoria.observations = codeDialog;

    int index = 0;
    while (index < listaProductos.length) {
      Item unItem = new Item();
      unItem.productId = listaProductos[index].id;
      unItem.presentationId = listaProductos[index].prices[0].presentation;
      if (unaAuditoria.items == null) {
        unaAuditoria.items = new List<Item>();
      }
      if (unItem.reasons == null) {
        unItem.reasons = new List<Reason>();
      }
      unaAuditoria.items.add(unItem);
      index++;
    }

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };

    http.post(urlBase + webServiceUrl,
        headers: header, body: auditoriaToJson(unaAuditoria));

    print(auditoriaToJson(unaAuditoria));
  }

  //Devuelve una lista de todas las consultas de stock
  Future<AuditoriaResponse> getAuditoriaStock() async {
    try {
      Response response = await _dio.get(urlBase + "Audit/NewAuditStock",
          //"https://run.mocky.io/v3/06fc7f65-bcf6-4e39-a91a-347e16e87e82",
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
}

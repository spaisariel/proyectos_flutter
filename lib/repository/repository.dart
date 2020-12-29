import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_info.dart';
import 'package:prueba3_git/models/product_info_response.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/models/user_response.dart';
import 'package:prueba3_git/screens/login_screen.dart';
//import 'package:prueba3_git/screens/login_screen.dart';

final String urlBase = 'http://192.168.0.15:45455/laplayacapacitacion/api/';

var getUserListUrl =
    'https://run.mocky.io/v3/12aadbfe-5ddd-42b4-8976-273a67ec116a';

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
                    //Navigator.of(context).pop();
                    // exit(1);
                  },
                )
              ],
            ));
  }

  final String respuestaString = respuesta.body;
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
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNpcyIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL3N1YnNjcmlwdG9yIjoibGFwbGF5YWNhcGFjaXRhY2lvbiIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL2lkdXN1YXJpbyI6IjIiLCJyb2xlIjoiMTExIiwiaHR0cDovL3NjaGVtYXMuZ3lhLmNvbS9pZGVudGl0eS9jbGFpbXMvY29kaWdvc3VjdXJzYWwiOiIxIiwibmJmIjoxNjA4MTQ0NTc3LCJleHAiOjE2MDk0NDA1NzcsImlhdCI6MTYwODE0NDU3NywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0OTIyMCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDkyMjAifQ.D-gqLpm4YhdisvMX62cJJ0pzoVzOBhhk13qe5CP65is';

  //////////////////////////////////////////////////////////////////////////////
  ///////////////METODOS GET PARA OBTENCION DE DATOS ///////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(
          "https://run.mocky.io/v3/314d5880-6604-492d-976a-b944932f831e",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      UserResponse userResponse = new UserResponse(userFromJson(x), "");
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

  // void postNuevaAuditoria(context) {
  //   String token =
  //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNpcyIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL3N1YnNjcmlwdG9yIjoibGFwbGF5YWNhcGFjaXRhY2lvbiIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL2lkdXN1YXJpbyI6IjIiLCJyb2xlIjoiMTExIiwiaHR0cDovL3NjaGVtYXMuZ3lhLmNvbS9pZGVudGl0eS9jbGFpbXMvY29kaWdvc3VjdXJzYWwiOiIxIiwibmJmIjoxNjA3OTc5MDM1LCJleHAiOjE2MDkyNzUwMzUsImlhdCI6MTYwNzk3OTAzNSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0OTIyMCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDkyMjAifQ.BCPuDem_1Pg2PcGxyqI1-FVD61v8wGRNywIo-46ffHU";
  //   //String token = usuario.token;
  //   List<Auditoria> detalleAuditorias;
  //   String webServiceUrl = 'Audit/NewAuditStock';

  //   Auditoria unaAuditoria;
  //   unaAuditoria.branchOfficeId = 1;
  //   unaAuditoria.depositId = 1;
  //   unaAuditoria.observations = "Auditoria prueba";
  //   unaAuditoria.items.productId = "58";
  //   unaAuditoria.items.quantity = 10;
  //   unaAuditoria.items.presentationId = "Unidad";

  //   detalleAuditorias.add(unaAuditoria);

  //   Map<String, String> header = {
  //     'Content-Type': 'application/json; charset=utf-8',
  //     'Authorization': 'Bearer $token',
  //   };

  //   http.post(urlBase + webServiceUrl,
  //       headers: header, body: auditoriaToJson(detalleAuditorias));

  //   print(auditoriaToJson(detalleAuditorias));
  // }
}

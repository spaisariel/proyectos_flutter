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

final String urlBase = 'http://192.168.1.16:45455/laplayacapacitacion/api/';

var getUserListUrl =
    'https://run.mocky.io/v3/12aadbfe-5ddd-42b4-8976-273a67ec116a';

void _logout(context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => LoginScreen()), (r) => false);
}

//Se llama desde Login1Screen, logea un usuario
Future<User> postLogin(BuildContext context, String nombre, String password,
    String idDevice) async {
  final String webServiceUrl = '/account/login';

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
                FlatButton(
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

class Repository {
  final Dio _dio = Dio();

  //Despues sacar el token de acá
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNpcyIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL3N1YnNjcmlwdG9yIjoibGFwbGF5YSIsImh0dHA6Ly9zY2hlbWFzLmd5YS5jb20vaWRlbnRpdHkvY2xhaW1zL2lkdXN1YXJpbyI6IjIiLCJyb2xlIjoiMTExIiwiaHR0cDovL3NjaGVtYXMuZ3lhLmNvbS9pZGVudGl0eS9jbGFpbXMvY29kaWdvc3VjdXJzYWwiOiIxIiwibmJmIjoxNjA1NzkxNzkwLCJleHAiOjE2MDcwODc3OTAsImlhdCI6MTYwNTc5MTc5MCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0OTIyMCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDkyMjAifQ.Kb2UG4EeCxcjXmxCV3INuzGtI4xzqJaDb000QJxrEmA';

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(
          "https://run.mocky.io/v3/12aadbfe-5ddd-42b4-8976-273a67ec116a",
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      UserResponse userResponse = new UserResponse(userFromJson(x), "");
      return userResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<AuditoriaResponse> getAuditoriaList() async {
    try {
      Response response = await _dio.get(
          "https://run.mocky.io/v3/c2e330da-9b24-4a2e-985f-e4979afff262",
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
}

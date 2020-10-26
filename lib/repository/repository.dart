import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prueba3_git/models/comment.dart';
import 'package:prueba3_git/models/comment_response.dart';
import 'package:prueba3_git/models/photo.dart';
import 'package:prueba3_git/models/photo_response.dart';
import 'package:prueba3_git/models/todo.dart';
import 'package:prueba3_git/models/todo_response.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/models/user_response.dart';

class Repository {
  //final String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  static String mainUrl = "https://jsonplaceholder.typicode.com";
  final Dio _dio = Dio();
  var getPhotoListUrl = '$mainUrl/photos';
  var getCommentListUrl = '$mainUrl/comments';
  var getUserListUrl = '$mainUrl/users';
  var getTodoListUrl = '$mainUrl/todos';

  Future<PhotoResponse> getPhotoList() async {
    try {
      Response response = await _dio.get(getPhotoListUrl,
          options: Options(responseType: ResponseType.json));
      //Map<String, dynamic> jsonList =          json.decode(response.data.toString()) as Map;
      // List<Album> myList =jsonList.map((jsonElement) => Album.fromJson(jsonElement)).toList();
      //var map = Map<String, dynamic>.from(response.data);
      //final List<dynamic> body = response.data;
      //print("!!!!!!---->" + response.data);
      String x = json.encode(response.data);
      PhotoResponse photoResponse = new PhotoResponse(photoFromJson(x), "");
      return photoResponse;
      //PhotoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PhotoResponse.withError("$error");
    }
  }

  Future<CommentResponse> getCommentList() async {
    try {
      Response response = await _dio.get(getCommentListUrl,
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      CommentResponse commentResponse =
          new CommentResponse(commentFromJson(x), "");
      return commentResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CommentResponse.withError("$error");
    }
  }

  Future<UserResponse> getUserList() async {
    try {
      Response response = await _dio.get(getUserListUrl,
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      UserResponse userResponse = new UserResponse(userFromJson(x), "");
      return userResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<TodoResponse> getTodoList() async {
    try {
      Response response = await _dio.get(getTodoListUrl,
          options: Options(responseType: ResponseType.json));
      String x = json.encode(response.data);
      TodoResponse todoResponse = new TodoResponse(todoFromJson(x), "");
      return todoResponse;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TodoResponse.withError("$error");
    }
  }
}

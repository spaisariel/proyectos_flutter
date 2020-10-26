import 'package:prueba3_git/models/todo.dart';

class TodoResponse {
  final List<Todo> todos;
  final String error;

  TodoResponse(this.todos, this.error);

  TodoResponse.fromJson(Map<String, dynamic> json)
      : todos =
            (json["results"] as List).map((i) => new Todo.fromJson(i)).toList(),
        error = "";

  TodoResponse.withError(String errorValue)
      : todos = List(),
        error = errorValue;
}

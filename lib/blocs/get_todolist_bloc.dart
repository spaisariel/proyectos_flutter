import 'package:prueba3_git/models/todo_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class TodoListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<TodoResponse> _subject =
      BehaviorSubject<TodoResponse>();

  getTodoLista() async {
    TodoResponse response = await _repository.getTodoList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TodoResponse> get subject => _subject;
}

final todoListBloc = TodoListBloc();

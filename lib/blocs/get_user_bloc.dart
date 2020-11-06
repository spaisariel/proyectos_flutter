import 'package:prueba3_git/models/user_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getUserLista() async {
    UserResponse response = await _repository.getUserList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final userListBloc = UserListBloc();

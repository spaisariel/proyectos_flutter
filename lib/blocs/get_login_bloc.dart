import 'dart:async';
import 'validaciones_login.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validaciones {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Agrega info al stream
  Stream<String> get email => _email.stream.transform(validarEmail);
  Stream<String> get password => _password.stream.transform(validarPassword);
  Stream<bool> get validacionLogin =>
      Rx.combineLatest2(email, password, (e, p) => true);

//cambiar la info
  Function(String) get cambiarEmail => _email.sink.add;
  Function(String) get cambiarPassword => _password.sink.add;

  enviar() {
    final validarEmail = _email.value;
    final validarPassword = _password;

    print('Email es $validarEmail');
    print('Password es $validarPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}

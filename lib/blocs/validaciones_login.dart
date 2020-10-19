import 'dart:async';

class Validaciones {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') && email.contains('.com')) {
      sink.add(email);
    } else
      sink.addError('Ingrese un email valido');
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else
      sink.addError('la contraseña debe tener mas de 4 caracteres');
  });
}

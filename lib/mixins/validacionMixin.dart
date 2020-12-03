class ValidacionMixin {
  String validacionEmail(String valor) {
    if (!valor.contains('@')) {
      return 'Por favor ingrese un email valido';
    } else
      return null;
  }

  String validacionUsuario(String valor) {
    if (valor.isEmpty) {
      return 'Por favor ingrese un nombre de usuario';
    } else
      return null;
  }

  String validacionPassword(String valor) {
    if (valor.isEmpty) {
      return 'Ingrese su contraseña';
    } else
      return null;
  }
}

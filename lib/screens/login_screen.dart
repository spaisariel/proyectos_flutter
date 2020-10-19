import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 100),
          Icon(Icons.ac_unit),
          emailField(),
          passwordField(),
          botonLogin(),
        ],
      )),
    );
  }
}

Widget emailField() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'ejemplo@ejemplo.com',
          labelText: 'Direccion de correo',
        ),
      );
    },
  );
}

Widget passwordField() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
        ),
      );
    },
  );
}

Widget botonLogin() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return RaisedButton(
          child: Text('Ingresar'),
          color: Style.Colors.mainColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login2Screen(),
              ),
            );
          });
    },
  );
}

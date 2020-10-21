import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 75),
            Icon(
              Icons.ac_unit,
              size: 200,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Bienvenidos!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              'Inicie sesión para continuar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 25,
            ),
            emailField(),
            passwordField(),
            SizedBox(
              height: 50,
            ),
            botonLogin(),
          ],
        )),
      ),
    );
  }
}

Widget emailField() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return FractionallySizedBox(
        widthFactor: 0.4,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'ejemplo@ejemplo.com',
            labelText: 'Direccion de correo',
          ),
        ),
      );
    },
  );
}

Widget passwordField() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return FractionallySizedBox(
        widthFactor: 0.4,
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
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
          color: Style.Colors.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
            side: BorderSide(color: Style.Colors.mainColor),
          ),
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

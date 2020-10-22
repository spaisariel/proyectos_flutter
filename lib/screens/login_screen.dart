import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Center(
            child: Column(
          children: [
            Container(
              child: new Image.asset(
                'lib/assets/favicon.png',
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 25),
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
          child: Text('Ingresar', style: TextStyle(color: Colors.white)),
          color: Style.Colors.mainColor,
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

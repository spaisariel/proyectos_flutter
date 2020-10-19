// import 'package:flutter/material.dart';
// import '../blocs/get_login_bloc.dart';
// import '../provider/provider_login.dart';

// class LoginScreen extends StatelessWidget {
//   Widget build(context) {
//     final bloc = Provider.of(context);

//     return Container(
//       margin: EdgeInsets.all(20.0),
//       child: Column(children: [
//         emailField(bloc),
//         passwordField(bloc),
//         Container(margin: EdgeInsets.only(top: 25.0)),
//         botonLogin(bloc),
//       ]),
//     );
//   }

//   Widget emailField(Bloc bloc) {
//     return StreamBuilder(
//       stream: bloc.email,
//       builder: (context, snapshot) {
//         return TextField(
//           onChanged: bloc.cambiarEmail,
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//               hintText: 'ejemplo@ejemplo.com',
//               labelText: 'Direccion de correo',
//               errorText: snapshot.error),
//         );
//       },
//     );
//   }

//

// Widget botonLogin(Bloc bloc) {
//   return StreamBuilder(
//     stream: bloc.validacionLogin,
//     builder: (context, snapshot) {
//       return RaisedButton(
//         child: Text('Ingresar'),
//         color: Colors.amberAccent,
//         onPressed: snapshot.hasData
//             ? () {
//                 // ignore: unnecessary_statements
//                 bloc.enviar;
//                 print("" + bloc.enviar.toString());
//               }
//             : null,
//       );
//     },
//   );
// }
// }

/*
class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: [
        emailField(bloc),
        passwordField(bloc),
        Container(margin: EdgeInsets.only(top: 25.0)),
        botonLogin(bloc),
      ]),
    );
  }*/

import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [
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
          color: Colors.amberAccent,
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

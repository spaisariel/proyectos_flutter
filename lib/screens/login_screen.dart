import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/screens/menu_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (error) {
      print(error);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Center(
          child: Container(
            child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Bienvenido!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        _googleSignIn.currentUser.displayName,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 22),
                      ),
                      SizedBox(height: 25),
                      (_googleSignIn.currentUser.photoUrl == null)
                          ? Image.asset('lib/assets/no_photo.png',
                              height: 100, width: 100)
                          : NetworkImage(_googleSignIn.currentUser.photoUrl),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sucursal ',
                            style: TextStyle(fontSize: 20),
                          ),
                          ComboBoxSucursalWidget()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Deposito ',
                            style: TextStyle(fontSize: 20),
                          ),
                          ComboBoxDepositoWidget(),
                        ],
                      ),
                      SizedBox(height: 15),
                      selecionarComercio(),
                      SizedBox(height: 25),
                      RaisedButton(
                        child: Text('Continuar',
                            style: TextStyle(color: Colors.white)),
                        color: Style.Colors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          side: BorderSide(color: Style.Colors.mainColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MenuScreen()));
                        },
                      ),
                      RaisedButton.icon(
                          color: Style.Colors.mainColor,
                          shape:
                              Style.Shapes.botonGrandeRoundedRectangleBorder(),
                          onPressed: () {
                            _logout();
                          },
                          icon: Image.asset('lib/assets/g logo.png',
                              height: 20,
                              width: 20,
                              color: Style.Colors.secondColor),
                          label: Text(
                            'Logout de Google',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        child: new Image.asset(
                          'lib/assets/favicon.png',
                          height: 65,
                          //height: MediaQuery.of(context).size.height * 0.1,
                          //fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Bienvenidos!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        'Inicie sesión para continuar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
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
                      RaisedButton.icon(
                          color: Style.Colors.mainColor,
                          shape:
                              Style.Shapes.botonGrandeRoundedRectangleBorder(),
                          onPressed: () {
                            _login();
                          },
                          icon: Image.asset('lib/assets/g logo.png',
                              height: 20,
                              width: 20,
                              color: Style.Colors.secondColor),
                          label: Text(
                            'Iniciar con Google',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ],
                  ),
          ),
        ),
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

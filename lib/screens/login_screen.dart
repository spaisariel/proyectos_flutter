import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/mixins/validacionMixin.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/screens/menu_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  const LoginScreen({Key key, this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidacionMixin {
  final formkey = GlobalKey<FormState>();

  bool _isLoggedIn = false;
  String nombre = '';
  String password = '';
  User unUsuario;
  bool boolPassword = true;
  String idDevice;
  bool boolCargando = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void getIdDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    idDevice = androidInfo.androidId;
  }

  String base64password(String password) {
    String texto = password;
    List encodedTexto = utf8.encode(texto);
    String base64Str = base64.encode(encodedTexto);
    return base64Str;
  }

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
    getIdDevice();
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Center(
          key: formkey,
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
                      ButtonTheme(
                        minWidth: 215.0,
                        height: 40.0,
                        child: RaisedButton(
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
                      //emailField(),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ejemplo@ejemplo.com',
                            labelText: 'Direccion de correo',
                          ),
                          onSaved: (String valor) {
                            nombre = valor;
                          },
                        ),
                      ),
                      //passwordField(),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            labelText: 'Contraseña',
                          ),
                          onSaved: (String valor) {
                            password = base64password(valor);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      //botonLogin(),
                      ButtonTheme(
                        minWidth: 215.0,
                        height: 40.0,
                        child: RaisedButton(
                            child: Text('Ingresar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                            color: Style.Colors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              side: BorderSide(color: Style.Colors.mainColor),
                            ),
                            onPressed: () async {
                              setState(() {
                                boolCargando = true;
                              });

                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();

                                unUsuario = await postLogin(
                                    context, nombre, password, idDevice);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login2Screen(unUsuario),
                                    ));
                              }
                            }),
                      ),
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

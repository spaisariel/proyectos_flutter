import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/mixins/validacionMixin.dart';
import 'package:prueba3_git/models/branchOffice.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

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
  BranchOffice unaSucursal;

  String nombreSucursal = '';
  String nombreDeposito = '';
  String idSucursal;
  String idDeposito;

  final controladorUsuario = TextEditingController();
  final controladorContrasenia = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void getGoogleToken() async {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        print(googleKey.accessToken);
        print(googleKey.idToken);
        print(_googleSignIn.currentUser.displayName);
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }

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
    getGoogleToken();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Style.Colors.secondColor,
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Center(
            key: formkey,
            child: Container(
              child: _isLoggedIn
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Bienvenido!',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                              'Sucursal Paraná 2',
                              style: TextStyle(fontSize: 20),
                            ),
                            //ComboBoxSucursalWidget()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Deposito Federico Bandi',
                              style: TextStyle(fontSize: 20),
                            ),
                            //ComboBoxDepositoWidget(),
                          ],
                        ),
                        SizedBox(height: 15),
                        selecionarComercio(),
                        SizedBox(height: 25),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Style.Colors.mainColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              side: BorderSide(color: Style.Colors.mainColor),
                            )),
                          ),
                          child: Text('Continuar',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaginaInicial(unUsuario, idSucursal,
                                            idDeposito)));
                          },
                        ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Style.Colors.mainColor),
                              shape: MaterialStateProperty.all(Style.Shapes
                                  .botonGrandeRoundedRectangleBorder()),
                            ),
                            onPressed: () {
                              _logout();
                            },
                            icon: Image.asset('lib/assets/g logo.png',
                                height: 20,
                                width: 20,
                                color: Style.Colors.secondColor),
                            label: Text(
                              'Logout de Google',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'ejemplo@ejemplo.com',
                              labelText: 'Direccion de correo',
                            ),
                            controller: controladorUsuario,
                            // onSaved: (String valor) {
                            //   nombre = valor;
                            // },
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
                            controller: controladorContrasenia,
                            // onSaved: (String valor) {
                            //   password = base64password(valor);
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Style.Colors.mainColor),
                                  shape: MaterialStateProperty.all(Style.Shapes
                                      .botonGrandeRoundedRectangleBorder())),
                              child: Text('Ingresar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () async {
                                password =
                                    base64password(controladorContrasenia.text);
                                unUsuario = await postLogin(
                                    context,
                                    controladorUsuario.text,
                                    password,
                                    idDevice);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login2Screen(unUsuario),
                                    ));
                                setState(() {
                                  boolCargando = true;
                                });
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Style.Colors.mainColor),
                                  shape: MaterialStateProperty.all(Style.Shapes
                                      .botonGrandeRoundedRectangleBorder())),
                              onPressed: () async {
                                _login();
                                unUsuario = await postLoginConGoogle(context,
                                    _googleSignIn.currentUser.email, idDevice);
                              },
                              icon: Image.asset('lib/assets/g logo.png',
                                  height: 20,
                                  width: 20,
                                  color: Style.Colors.secondColor),
                              label: Text(
                                'Iniciar con Google',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget seleccionarSucursal(String sucursal, String idSucursal) {
    String dropdownValue = sucursal;
    return StreamBuilder(builder: (context, snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 20),
        underline: Container(
          height: 2,
          color: Style.Colors.secondColor,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            nombreSucursal = newValue;
            this.idSucursal = idSucursal;
          });
        },
        items: <String>[sucursal.toString()]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }

  Widget seleccionarDeposito(List<Deposit> depositos) {
    String dropdownValue = depositos[0].name;
    List<String> nombreDepositos =
        depositos.map((deposito) => deposito.name).toList();
    return StreamBuilder(builder: (context, snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 20),
        underline: Container(
          height: 2,
          color: Style.Colors.secondColor,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            nombreDeposito = newValue;
            depositos.forEach((deposito) {
              if (deposito.name == newValue) {
                idDeposito = deposito.depositId;
              }
            });
          });
        },
        items: nombreDepositos.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}

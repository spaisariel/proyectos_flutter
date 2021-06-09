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

//import '../main.dart';

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

  bool isButtonDisabled = true;

  final controladorUsuario = TextEditingController();
  final controladorContrasenia = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void getGoogleToken() async {
    _googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        // print(googleKey.accessToken);
        // print(googleKey.idToken);
        // print(_googleSignIn.currentUser.displayName);
        // print(_googleSignIn.currentUser.email);
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

  Widget build(BuildContext context) {
    getIdDevice();
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
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Login2Screen(unUsuario),
                      ))
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
                        FittedBox(
                          child: Column(
                            children: [
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'ejemplo@ejemplo.com',
                              labelText: 'Direccion de correo o usuario',
                            ),
                            controller: controladorUsuario,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              labelText: 'Contraseña',
                            ),
                            controller: controladorContrasenia,
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
                              child: FittedBox(
                                child: Text('Ingresar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                              onPressed: () async {
                                password =
                                    base64password(controladorContrasenia.text);
                                unUsuario = await postLogin(
                                    context,
                                    controladorUsuario.text,
                                    password,
                                    idDevice);
                                Navigator.pushReplacement(
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
                        (isButtonDisabled)
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: FittedBox(
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Style.Colors.mainColor),
                                          shape: MaterialStateProperty.all(Style
                                                  .Shapes
                                              .botonGrandeRoundedRectangleBorder())),
                                      onPressed: () async {
                                        getGoogleToken();
                                        setState(() {
                                          boolCargando = true;
                                          isButtonDisabled = false;
                                        });
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
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: FittedBox(
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Style.Colors.mainColor),
                                          shape: MaterialStateProperty.all(Style
                                                  .Shapes
                                              .botonGrandeRoundedRectangleBorder())),
                                      onPressed: () async {
                                        unUsuario = await postLoginConGoogle(
                                            context,
                                            _googleSignIn.currentUser.email,
                                            idDevice);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    Login2Screen(unUsuario)));
                                        setState(() {
                                          boolCargando = true;
                                        });
                                      },
                                      icon: Image.asset('lib/assets/g logo.png',
                                          height: 20,
                                          width: 20,
                                          color: Style.Colors.secondColor),
                                      label: Text(
                                        'Continuar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )),
                                ),
                              )
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

import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_user_bloc.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/models/user_response.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/screens/login_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    userListBloc..getUserLista();
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => LoginScreen()), (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: userListBloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(UserResponse data) {
    User unUsuario = data.users[0];

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                        "Perfil - ${unUsuario.nombre} ${unUsuario.apellido}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Column(children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.mail),
                  Column(
                    children: [
                      Text("E-Mail",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text(unUsuario.mail,
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),

            //SOLO A MODO DE PRUEBA, EN UN FUTURO QUEDARIA UN SOLO LIST TILE
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.phone),
                  Column(
                    children: [
                      Text("Telefono",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text(unUsuario.telefono,
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.place),
                  Column(
                    children: [
                      Text("Dirección",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text(unUsuario.direccion,
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    _showMaterialDialog(context);
                  },
                  child: Text('Cambiar de sucursal o deposito',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),

            SizedBox(height: 25),

            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Style.Colors.cancelColor2,
                  onPressed: () {
                    _logout();
                  },
                  child: Text('Cerrar sesión',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ]),
        ),
      ),
    );
  }
}

_showMaterialDialog(context) {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Cambio de sucursal/deposito"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

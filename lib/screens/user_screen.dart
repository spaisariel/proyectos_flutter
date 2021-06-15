import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_user_bloc.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/models/user_response.dart';
import 'package:prueba3_git/screens/login_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class UserScreen extends StatefulWidget {
  final User usuario;
  UserScreen(this.usuario);

  @override
  _UserScreenState createState() => _UserScreenState(this.usuario);
}

class _UserScreenState extends State<UserScreen> {
  final User unUsuario;
  _UserScreenState(this.unUsuario);

  @override
  void initState() {
    super.initState();
    userListBloc..getUser();
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

  Widget _buildHomeWidget(UserResponse unUser) {
    User unUsuario = unUser.unUsuario;
    String email = "No aplica";
    String direccion = "No aplica";

    if (unUsuario.userInfo.email != null) {
      email = unUsuario.userInfo.email;
    }

    if (unUsuario.userInfo.addresses != null) {
      direccion = unUsuario.userInfo.addresses;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                        "${unUsuario.userInfo.firstName} ${unUsuario.userInfo.lastName}",
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
          body: Container(
            // decoration: BoxDecoration(
            //     color: Colors.yellow[100],
            //     border: Border.all(
            //       color: Colors.red,
            //       width: 5,
            //     )),
            child: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.mail),
                      Column(
                        children: [
                          Text("E-Mail",
                              style:
                                  TextStyle(color: Style.Colors.secondColor)),
                          Text(email,
                              style: TextStyle(color: Style.Colors.titleColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.phone),
                      Column(
                        children: [
                          Text("Telefono",
                              style:
                                  TextStyle(color: Style.Colors.secondColor)),
                          Text(unUsuario.userInfo.phone,
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
                              style:
                                  TextStyle(color: Style.Colors.secondColor)),
                          Text(direccion,
                              style: TextStyle(color: Style.Colors.titleColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Style.Colors.cancelColor2),
                        shape: MaterialStateProperty.all(
                            Style.Shapes.botonGrandeRoundedRectangleBorder())),
                    onPressed: () {
                      _logout();
                    },
                    child: Text(
                      'Cerrar sesión',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

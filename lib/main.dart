import 'package:flutter/material.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/screens/login_screen.dart';
import 'package:prueba3_git/screens/reportes_screen.dart';
import 'package:prueba3_git/screens/stock_screen.dart';
import 'package:prueba3_git/screens/user_screen.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

// ignore: must_be_immutable
class PaginaInicial extends StatefulWidget {
  final User usuario;
  String idSucursal;
  String idDeposito;

  PaginaInicial(this.usuario, this.idSucursal, this.idDeposito);

  @override
  _PaginaInicialState createState() =>
      _PaginaInicialState(this.usuario, this.idSucursal, this.idDeposito);
}

class _PaginaInicialState extends State<PaginaInicial> {
  final User usuario;
  String idSucursal;
  String idDeposito;
  _PaginaInicialState(this.usuario, this.idSucursal, this.idDeposito);

  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      StockScreen(idSucursal, idDeposito),
      ReportsScreen(),
      UserScreen(usuario),
    ];

    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              label: 'Stock',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.assessment),
              label: 'Reporteria',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.supervised_user_circle),
              label: 'Usuario',
            ),
          ]),
    );
  }
}

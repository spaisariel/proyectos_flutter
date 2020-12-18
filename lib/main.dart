import 'package:flutter/material.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/screens/login_screen.dart';
import 'package:prueba3_git/screens/reportes_screen.dart';
import 'package:prueba3_git/screens/stock_screen.dart';
import 'package:prueba3_git/screens/user_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

class PaginaInicial extends StatefulWidget {
  final User usuario;
  PaginaInicial(this.usuario);
  @override
  _PaginaInicialState createState() => _PaginaInicialState(this.usuario);
}

class _PaginaInicialState extends State<PaginaInicial> {
  //Color azulGrandi = new Color.fromARGB(255, 0, 141, 210);
  final User usuario;
  _PaginaInicialState(this.usuario);

  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      StockScreen(),
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
              icon: new Icon(Icons.keyboard_arrow_up),
              label: 'Mas',
            ),
          ]),
    );
  }
}

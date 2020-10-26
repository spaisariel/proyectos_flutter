import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
import 'package:prueba3_git/screens/stock_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    StockScreen(),
    Text("Coso1"),
    //ProductScreen(),
    Text("Coso2"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => Login2Screen()), (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Reporteria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_up),
            label: 'Mas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Style.Colors.mainColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

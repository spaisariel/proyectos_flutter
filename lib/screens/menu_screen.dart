import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/stock_screen.dart';
import 'package:prueba3_git/screens/user_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

/// This is the stateful widget that the main application instantiates.
class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

/// This is the private State class that goes with MenuScreen.
class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    StockScreen(),
    Text(
      "Reportes",
      style: TextStyle(fontSize: 40),
    ),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _logout() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (c) => Login2Screen()), (r) => false);
  // }

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

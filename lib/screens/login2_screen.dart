import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/menu_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class Login2Screen extends StatefulWidget {
  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

Color azulGrandi = new Color.fromARGB(255, 0, 141, 210);

class _Login2ScreenState extends State<Login2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit,
              size: 200,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Sucursal '), ComboBoxSucursalWidget()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Deposito '),
                ComboBoxDepositoWidget(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            //Spacer(),
            ButtonTheme(
              minWidth: 200.0,
              child: continuarButton(context),
            ),
            omitirButton(context),
          ],
        ),
      ),
    );
  }
}

class ComboBoxSucursalWidget extends StatefulWidget {
  ComboBoxSucursalWidget({Key key}) : super(key: key);

  @override
  _ComboBoxSucursalWidgetState createState() => _ComboBoxSucursalWidgetState();
}

/// This is the private State class that goes with ComboBoxSucursalWidget.
class _ComboBoxSucursalWidgetState extends State<ComboBoxSucursalWidget> {
  String dropdownValue = 'Casa central';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Style.Colors.mainColor),
      underline: Container(
        height: 2,
        color: Style.Colors.secondColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Casa central', 'Sucursal  1', 'Sucursal 2', 'Sucursal 3']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class ComboBoxDepositoWidget extends StatefulWidget {
  ComboBoxDepositoWidget({Key key}) : super(key: key);

  @override
  _ComboBoxDepositoWidgetState createState() => _ComboBoxDepositoWidgetState();
}

/// This is the private State class that goes with ComboBoxSucursalWidget.
class _ComboBoxDepositoWidgetState extends State<ComboBoxDepositoWidget> {
  String dropdownValue = 'Deposito 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Style.Colors.mainColor),
      underline: Container(
        height: 2,
        color: Style.Colors.secondColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Deposito 1', 'Deposito 2', 'Deposito 3', 'Deposito 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

Widget continuarButton(context) {
  return RaisedButton(
    color: Style.Colors.secondColor,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(8.0),
      side: BorderSide(color: Style.Colors.mainColor),
    ),
    child: Text('Continuar', style: TextStyle(color: Style.Colors.mainColor)),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MenuScreen()));
    },
  );
}

Widget omitirButton(context) {
  return RaisedButton(
    color: Style.Colors.secondColor,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(8.0),
      side: BorderSide(color: Style.Colors.mainColor),
    ),
    child: Text('Omitir', style: TextStyle(color: Style.Colors.mainColor)),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuScreen(),
        ),
      );
    },
  );
}

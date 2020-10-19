import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login2Screen extends StatefulWidget {
  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

Color azulGrandi = new Color.fromARGB(255, 0, 141, 210);

class _Login2ScreenState extends State<Login2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Icon(
              Icons.ac_unit,
              size: 200,
            ),
            Text('Sucursal'),
            ComboBoxSucursalWidget(),
            Text('Deposito'),
            ComboBoxDepositoWidget(),
            RaisedButton(
              child: Text('Continuar'),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('Omitir'),
              onPressed: () {},
            ),
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
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
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
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
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

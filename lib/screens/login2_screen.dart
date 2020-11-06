import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/maps_screen.dart';
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
      backgroundColor: Style.Colors.secondColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Center(
          child: Column(
            children: [
              Container(
                child: new Image.asset(
                  'lib/assets/favicon.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),
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
              ),

              SizedBox(height: 15),
              selecionarComercio(),

              SizedBox(height: 100),

              //Spacer(),
              ButtonTheme(
                minWidth: 200.0,
                child: continuarButton(context),
              ),
              omitirButton(context),
            ],
          ),
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

Widget continuarButton(
  context,
) {
  return RaisedButton(
    color: Style.Colors.mainColor,
    shape: botonRoundedRectangleBorder(),
    child: Text('Continuar', style: TextStyle(color: Colors.white)),
    // onPressed: () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MenuScreen()));
    // },
    onPressed: () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => MenuScreen()));
    },
  );
}

Widget omitirButton(context) {
  return RaisedButton(
    color: Style.Colors.mainColor,
    shape: botonRoundedRectangleBorder(),
    child: Text('Omitir', style: TextStyle(color: Colors.white)),
    onPressed: () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => MenuScreen()));
    },
  );
}

RoundedRectangleBorder botonRoundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(8.0),
    side: BorderSide(color: Style.Colors.mainColor),
  );
}

Widget selecionarComercio() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return RaisedButton(
          child:
              Text('Buscar en el mapa', style: TextStyle(color: Colors.white)),
          color: Style.Colors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
            side: BorderSide(color: Style.Colors.mainColor),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapaScreen(),
              ),
            );
          });
    },
  );
}

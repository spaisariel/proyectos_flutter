import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import '../style/theme.dart' as Style;

class BotonesPrincipalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            onPressed: () {},
            icon: Icon(Icons.shopping_cart,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Auditoria de gondola',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //UNICAMENTE PARA PRUEBA
                  builder: (context) => ProductScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.assignment_turned_in,
              color: Style.Colors.secondColor,
              size: 40,
            ),
            label: Text('Control de inventario',
                style: TextStyle(color: Colors.white, fontSize: 20))),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            onPressed: () {},
            icon: Icon(Icons.assignment,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Consulta de auditorias',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      )
    ]);
  }
}

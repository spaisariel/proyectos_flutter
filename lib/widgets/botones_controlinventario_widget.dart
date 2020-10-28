import 'package:flutter/material.dart';

import '../style/theme.dart' as Style;

class BotonesControlInventarioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonTheme(
          buttonColor: Style.Colors.cancelColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Text('Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('control',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        ),
        SizedBox(width: 20),
        ButtonTheme(
          buttonColor: Style.Colors.acceptColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Text('Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('control',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Colors {
  const Colors();
//para agregar un color hexadecimal por ej #357ebd agregarle al principio 0xFF y sacarle el numeral y luego el color -> 0xFF357edb

  //Azul Grandi
  static const Color mainColor = const Color(0xFF357ebd);

  //Gris claro
  static const Color secondColor = const Color(0xFFCCCCCC);

  //Negro
  static const Color titleColor = const Color(0xFF000000);

  //Rojo cancelar
  static const Color cancelColor = const Color(0xFFFF0000);

  static const Color blanco = const Color(0xFFFFFFFF);
}

class Shapes {
//shape para botones grandes
  static RoundedRectangleBorder botonGrandeRoundedRectangleBorder() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
  }
}

class ButtonThemes {
  static botonGrandeButtonTheme(
    context,
    IconData icon,
    String title,
  ) {
    return ButtonTheme(
      buttonColor: Colors.mainColor,
      height: MediaQuery.of(context).size.height * 0.1,
      minWidth: MediaQuery.of(context).size.width * 0.8,
      child: RaisedButton.icon(
          shape: Shapes.botonGrandeRoundedRectangleBorder(),
          onPressed: () {},
          icon: Icon(
            Icons.assignment_turned_in,
            color: Colors.secondColor,
            size: 40,
          ),
          label: Text(title,
              style: TextStyle(color: Colors.blanco, fontSize: 20))),
    );
  }
}

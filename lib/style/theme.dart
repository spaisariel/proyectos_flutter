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

  static const Color cancelColor2 = const Color(0xFFFF5252);

  static const Color acceptColor = const Color(0xFF8BC34A);

  static const Color acceptColor2 = const Color(0xFF4CAF50);
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
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: Shapes.botonGrandeRoundedRectangleBorder(),
          ),
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

  static botonChicoButtonTheme(
    context,
    String title,
  ) {
    return ButtonTheme(
      buttonColor: Colors.mainColor,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: Shapes.botonGrandeRoundedRectangleBorder(),
          ),
          onPressed: () {},
          child: Text(title,
              style: TextStyle(color: Colors.blanco, fontSize: 10))),
    );
  }
}

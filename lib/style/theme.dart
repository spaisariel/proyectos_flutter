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

// class ChartColors {
//   static const List<Color> coloresGraficos = [];
//   static const Color color1 = const Color(0xFF357ebd);
//   static const Color color2 = const Color(0xFFFF0000);
//   static const Color color3 = const Color(0xFF4CAF50);
//   static const Color color4 = const Color(0xFF880E4F);
//   static const Color color5 = const Color(0xFFF4511E);
//   static const Color color6 = const Color(0xFFFFC107);
//   static const Color color7 = const Color(0xFFCDDC39);
//   static const Color color8 = const Color(0xFF009688);
//   static const Color color9 = const Color(0xFF03A9F4);
//   static const Color color10 = const Color(0xFF00ACC1);
//   static const Color color11 = const Color(0xFFFFEB3B);
//   static const Color color12 = const Color(0xFF9C27B0);
//   static const Color color13 = const Color(0xFF607D8B);
//   static const Color color14 = const Color(0xFF4CAF50);
//   static const Color color15 = const Color(0xFF673AB7);
//   static const Color color16 = const Color(0xFF3F51B5);
//   static const Color color17 = const Color(0xFF795548);
//   static const Color color18 = const Color(0xFF9E9E9E);
//   static const Color color19 = const Color(0xFF880E4F);
//   static const Color color20 = const Color(0xFFF8BBD0);
//   static const Color color21 = const Color(0xFFE65100);
//   static const Color color22 = const Color(0xFF827717);
//   static const Color color23 = const Color(0xFF64DD17);
//   static const Color color24 = const Color(0xFF1B5E20);
//   static const Color color25 = const Color(0xFF004D40);
//   static const Color color26 = const Color(0xFF33691E);
//   static const Color color27 = const Color(0xFF006064);
//   static const Color color28 = const Color(0xFFAA00FF);
//   static const Color color29 = const Color(0xFF4A148C);
//   static const Color color30 = const Color(0xFF01579B);
//   static const Color color31 = const Color(0xFF263238);
//   static const Color color32 = const Color(0xFF311B92);
//   static const Color color33 = const Color(0xFF3E2723);
//   static const Color color34 = const Color(0xFF212121);

//   List<Color> listaColores() {
//     coloresGraficos.add(color1);
//     coloresGraficos.add(color2);
//     coloresGraficos.add(color3);
//     coloresGraficos.add(color4);
//     coloresGraficos.add(color5);
//     coloresGraficos.add(color6);
//     coloresGraficos.add(color7);
//     coloresGraficos.add(color8);
//     coloresGraficos.add(color9);
//     coloresGraficos.add(color10);
//     coloresGraficos.add(color11);
//     coloresGraficos.add(color12);
//     coloresGraficos.add(color13);
//     coloresGraficos.add(color14);
//     coloresGraficos.add(color15);
//     coloresGraficos.add(color16);
//     coloresGraficos.add(color17);
//     coloresGraficos.add(color18);
//     coloresGraficos.add(color19);
//     coloresGraficos.add(color20);
//     coloresGraficos.add(color21);
//     coloresGraficos.add(color22);
//     coloresGraficos.add(color23);
//     coloresGraficos.add(color24);
//     coloresGraficos.add(color25);
//     coloresGraficos.add(color26);
//     coloresGraficos.add(color27);
//     coloresGraficos.add(color28);
//     coloresGraficos.add(color29);
//     coloresGraficos.add(color30);
//     coloresGraficos.add(color31);
//     coloresGraficos.add(color32);
//     coloresGraficos.add(color33);
//     coloresGraficos.add(color34);
//     return coloresGraficos;
//   }
// }

class ButtonThemes {
  static botonGrandeButtonTheme(
    context,
    IconData icon,
    String title,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.1),
      // buttonColor: Colors.mainColor,
      // height: MediaQuery.of(context).size.height * 0.1,
      // minWidth: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton.icon(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                  Shapes.botonGrandeRoundedRectangleBorder())),
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
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                  Shapes.botonGrandeRoundedRectangleBorder())),
          // style: ElevatedButton.styleFrom(
          //   shape: Shapes.botonGrandeRoundedRectangleBorder(),
          // ),
          onPressed: () {},
          child: Text(title,
              style: TextStyle(color: Colors.blanco, fontSize: 10))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prueba3_git/widgets/appbar_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBarWidget('Auditoria'),
      body: ListView(
        children: <Widget>[
          //BusquedaManual_widget()
          //Tabla_widget()
          //
        ],
      ),
      //navigationbar_widget()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prueba3_git/widgets/appbar_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBarWidget('Auditoria'),
      body: ListView(
        children: <Widget>[
          BotonesBusquedaWidget(),
          //Tabla_widget()
          //
        ],
      ),
      //navigationbar_widget()
    );
  }
}

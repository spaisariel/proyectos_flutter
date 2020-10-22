import 'package:flutter/material.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class BusquedaManualScreen extends StatefulWidget {
  BusquedaManualScreen({Key key}) : super(key: key);

  @override
  _BusquedaManualScreenState createState() => _BusquedaManualScreenState();
}

class _BusquedaManualScreenState extends State<BusquedaManualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Busqueda manual'),
        centerTitle: true,
      ),
      body: FiltroWidget(),
    );
  }
}

class FiltroWidget extends StatefulWidget {
  FiltroWidget({Key key}) : super(key: key);

  @override
  _FiltroWidgetState createState() => _FiltroWidgetState();
}

class _FiltroWidgetState extends State<FiltroWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      color: Style.Colors.secondColor,
    );
  }
}

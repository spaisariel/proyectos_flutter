import 'package:flutter/material.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';
import 'package:prueba3_git/widgets/botones_principal_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
            leading: new WillPopScope(
                onWillPop: () async => false, child: Text(''))),
        body: ListView(
          children: [
            BotonesBusquedaWidget(),
            BotonesPrincipalWidget(),
          ],
        ));
  }
}

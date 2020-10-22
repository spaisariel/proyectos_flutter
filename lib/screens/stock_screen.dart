import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/busquedamanual_screen.dart';
import 'package:prueba3_git/screens/login2_screen.dart';
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
            title: Text('Stock'),
            centerTitle: true,
            backgroundColor: Style.Colors.mainColor,
            leading: new WillPopScope(
                onWillPop: () async => false, child: Text(''))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BotonesBusquedaWidget(),
            SizedBox(height: 20),
            BotonesPrincipalWidget(),
          ],
        ));
  }
}

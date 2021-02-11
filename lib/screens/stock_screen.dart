import 'package:flutter/material.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';
import 'package:prueba3_git/widgets/botones_principal_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

// ignore: must_be_immutable
class StockScreen extends StatefulWidget {
  String idSucursal;
  String idDeposito;
  StockScreen(this.idSucursal, this.idDeposito);
  @override
  _StockScreenState createState() =>
      _StockScreenState(this.idSucursal, this.idDeposito);
}

class _StockScreenState extends State<StockScreen> {
  String idSucursal;
  String idDeposito;

  _StockScreenState(this.idSucursal, this.idDeposito);

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
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            BotonesBusquedaWidget("comun"),
            SizedBox(height: 20),
            BotonesPrincipalWidget(idSucursal, idDeposito),
          ],
        )));
  }
}

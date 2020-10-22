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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  buttonColor: Style.Colors.mainColor,
                  height: MediaQuery.of(context).size.height * 0.1,
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  child: RaisedButton.icon(
                      shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusquedaManualScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Style.Colors.secondColor,
                        size: 40,
                      ),
                      label: Column(
                        children: [
                          Text('Busqueda',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Text('Manual',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15))
                        ],
                      )),
                ),
                SizedBox(width: 20),
                ButtonTheme(
                  buttonColor: Style.Colors.mainColor,
                  height: MediaQuery.of(context).size.height * 0.1,
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  child: RaisedButton.icon(
                      shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera,
                        color: Style.Colors.secondColor,
                        size: 40,
                      ),
                      label: Column(
                        children: [
                          Text('Busqueda',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Text('QR',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15))
                        ],
                      )),
                )
              ],
            ),
            SizedBox(height: 20),
            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton.icon(
                  shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart,
                      size: 40, color: Style.Colors.secondColor),
                  label: Text(
                    'Auditoria de gondola',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            SizedBox(height: 20),
            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.assignment_turned_in,
                    color: Style.Colors.secondColor,
                    size: 40,
                  ),
                  label: Text('Control de inventario',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
            SizedBox(height: 20),
            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton.icon(
                  shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                  onPressed: () {},
                  icon: Icon(Icons.assignment,
                      size: 40, color: Style.Colors.secondColor),
                  label: Text(
                    'Consulta de auditorias',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )

            //BotonesBusquedaWidget(),
            //BotonesPrincipalWidget(),
          ],
        ));
  }
}

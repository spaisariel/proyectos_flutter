import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/screens/busqueda_productos_auditoria.dart';
import 'package:prueba3_git/screens/busqueda_productos_control.dart';

import 'package:prueba3_git/screens/busquedamanual_screen.dart';

import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesBusquedaWidget extends StatefulWidget {
  final String llamada;
  List<Reason> listaRazones;
  BotonesBusquedaWidget(this.llamada, this.listaRazones);
  @override
  _BotonesBusquedaWidgetState createState() =>
      _BotonesBusquedaWidgetState(this.llamada, this.listaRazones);
}

class _BotonesBusquedaWidgetState extends State<BotonesBusquedaWidget> {
  final String llamada;
  List<Reason> listaRazones;
  _BotonesBusquedaWidgetState(this.llamada, this.listaRazones);
  // ignore: unused_field
  String _scanBarcode = 'Desconocido';
  List<String> idProductos = new List<String>();

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Fallo al obtener la version de la plataforma.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ProductScreen(unProducto),
      //   ),
      // );
    } on PlatformException {
      barcodeScanRes = 'Fallo al obtener la version de la plataforma.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          textColor: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.23,
          color: Style.Colors.mainColor,
          shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
          onPressed: () async {
            if (llamada == "auditoria") {
              idProductos = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      BusquedaProductosAuditoriaScreen(listaRazones),
                ),
              );
            } else if (llamada == "inventario") {
              idProductos = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      BusquedaProductosControlScreen(),
                ),
              );
            } else {
              idProductos = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      BusquedaManualScreen(),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              Text('Manual'),
            ],
          ),
        ),
        SizedBox(width: 20),
        FlatButton(
          textColor: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.23,
          color: Style.Colors.mainColor,
          shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
          onPressed: () => scanQR(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                ),
              ),
              Text('QR'),
            ],
          ),
        ),
        SizedBox(width: 20),
        FlatButton(
          textColor: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.23,
          color: Style.Colors.mainColor,
          shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
          onPressed: () => scanBarcodeNormal(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.line_weight,
                  color: Colors.white,
                ),
              ),
              Text('Barras'),
            ],
          ),
        ),
      ],
    );
  }

  _showMaterialDialog(context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Seleccione su busqueda"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Style.Colors.mainColor,
                      //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      // ),
                      onPressed: () => scanBarcodeNormal(),
                      child: Text("Codigo de barras",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      // style: ElevatedButton.styleFrom(
                      //   primary: Style.Colors.mainColor,
                      //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      // ),
                      onPressed: () => scanQR(),
                      child: Text("QR",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  // RaisedButton(
                  //     onPressed: () => startBarcodeScanStream(),
                  //     child: Text("Stream codigo barras")),
                  // Text('Scan result : $_scanBarcode\n',
                  //     style: TextStyle(fontSize: 20))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

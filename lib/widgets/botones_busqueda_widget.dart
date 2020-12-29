import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/screens/busqueda_productos_auditoria.dart';

import 'package:prueba3_git/screens/busquedamanual_screen.dart';

import '../style/theme.dart' as Style;

class BotonesBusquedaWidget extends StatefulWidget {
  final bool llamada;
  BotonesBusquedaWidget(this.llamada);
  @override
  _BotonesBusquedaWidgetState createState() =>
      _BotonesBusquedaWidgetState(this.llamada);
}

class _BotonesBusquedaWidgetState extends State<BotonesBusquedaWidget> {
  final bool llamada;
  _BotonesBusquedaWidgetState(this.llamada);
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
    // Platform messages may fail, so we use a try/catch PlatformException.
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
        ButtonTheme(
          buttonColor: Style.Colors.mainColor,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton.icon(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // style: ElevatedButton.styleFrom(
              //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // ),
              onPressed: () async {
                if (llamada) {
                  idProductos = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (
                        context,
                      ) =>
                          BusquedaProductosAuditoriaScreen(),
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
              icon: Icon(
                Icons.edit,
                color: Style.Colors.secondColor,
                size: 40,
              ),
              label: Column(
                children: [
                  Text('Busqueda',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('Manual',
                      style: TextStyle(color: Colors.white, fontSize: 15))
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
              // style: ElevatedButton.styleFrom(
              //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // ),
              onPressed: () {
                _showMaterialDialog(context);
              },
              icon: Icon(
                Icons.camera,
                color: Style.Colors.secondColor,
                size: 40,
              ),
              label: Column(
                children: [
                  Text('Busqueda',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('QR',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        )
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

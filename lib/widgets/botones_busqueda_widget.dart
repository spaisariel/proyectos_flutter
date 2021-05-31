import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/screens/busqueda_productos_auditoria.dart';
import 'package:prueba3_git/screens/busqueda_productos_control.dart';

import 'package:prueba3_git/screens/busquedamanual_screen.dart';
import 'package:prueba3_git/screens/product_screen.dart';

import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesBusquedaWidget extends StatefulWidget {
  final String llamada;
  List<Reason> listaRazones;
  List<Product> listaProductos;
  BotonesBusquedaWidget(this.llamada, this.listaRazones, this.listaProductos);
  @override
  _BotonesBusquedaWidgetState createState() => _BotonesBusquedaWidgetState(
      this.llamada, this.listaRazones, this.listaProductos);
}

class _BotonesBusquedaWidgetState extends State<BotonesBusquedaWidget> {
  final String llamada;
  List<Reason> listaRazones;
  List<Product> listaProductos;
  List<Item> listaItems;
  _BotonesBusquedaWidgetState(
      this.llamada, this.listaRazones, this.listaProductos);
  // ignore: unused_field
  String _scanBarcode = 'Desconocido';
  List<Item> idProductos = [];

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
    String qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      if (qrScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(qrScanRes, '', listaRazones),
          ),
        );
      }
    } on PlatformException {
      qrScanRes = 'Fallo al obtener la version de la plataforma.';
    }

    if (!mounted) {
      Navigator.pop(context);
    }

    setState(() {
      _scanBarcode = qrScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      if (barcodeScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductScreen(barcodeScanRes, '', listaRazones),
          ),
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Fallo al obtener la version de la plataforma.';
    }
    if (!mounted) {
      Navigator.pop(context);
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.height * 0.1),
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    Style.Shapes.botonGrandeRoundedRectangleBorder()),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Style.Colors.mainColor)),
            onPressed: () async {
              if (llamada == "auditoria") {
                idProductos = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) =>
                        BusquedaProductosAuditoriaScreen(
                            listaRazones, listaProductos),
                  ),
                );
              } else if (llamada == "inventario") {
                idProductos = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) =>
                        BusquedaProductosControlScreen(listaProductos),
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
                Text('Manual', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.height * 0.1),
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    Style.Shapes.botonGrandeRoundedRectangleBorder()),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Style.Colors.mainColor)),
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
                Text('QR', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.height * 0.1),
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    Style.Shapes.botonGrandeRoundedRectangleBorder()),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Style.Colors.mainColor)),
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
                Text('Barras', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

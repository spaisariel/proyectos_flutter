import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';

class BusquedaQRscreen extends StatefulWidget {
  @override
  _BusquedaQRscreenState createState() => _BusquedaQRscreenState();
}

class _BusquedaQRscreenState extends State<BusquedaQRscreen> {
  String _scanBarcode = 'Unknown';
  List<Product> lista;

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
    return StreamBuilder<ProductResponse>(
      stream: productListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(ProductResponse data) {
    lista = data.products;

    if (lista.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No se encuentra el producto",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Scaffold(
          appBar: AppBar(title: const Text('Escaner')),
          body: Builder(builder: (BuildContext context) {
            return Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () => scanBarcodeNormal(),
                          child: Text("Codigo de barras")),
                      ElevatedButton(
                          onPressed: () => scanQR(), child: Text("QR")),
                      ElevatedButton(
                          onPressed: () => startBarcodeScanStream(),
                          child: Text("Stream codigo barras")),
                      Text('Scan result : $_scanBarcode\n',
                          style: TextStyle(fontSize: 20))
                    ]));
          }));
  }
}

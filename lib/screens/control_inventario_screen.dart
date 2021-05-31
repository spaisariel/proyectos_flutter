import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/screens/busqueda_productos_control.dart';

// ignore: must_be_immutable
class ControlInventarioScreen extends StatefulWidget {
  String idSucursal;
  String idDeposito;
  List<Product> listaProductos;
  List<Item> listaItems;

  ControlInventarioScreen(
      this.listaProductos, this.idSucursal, this.idDeposito, this.listaItems);
  @override
  _ControlInventarioScreenState createState() => _ControlInventarioScreenState(
      this.listaProductos, this.idSucursal, this.idDeposito, this.listaItems);
}

class _ControlInventarioScreenState extends State<ControlInventarioScreen> {
  List<Product> listaProductos;
  String idSucursal;
  String idDeposito;
  List<Item> listaItems = [];
  List<Reason> listaRazones;
  List<Item> items = [];
  _ControlInventarioScreenState(
      this.listaProductos, this.idSucursal, this.idDeposito, this.listaItems);

  String codeDialog = '';

  // ignore: unused_field
  String _scanBarcode = 'Desconocido';

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idSucursal = this.idSucursal;
    idDeposito = this.idDeposito;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Control de inventario'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildSearchButtons(),
            SizedBox(height: 30),
            (listaItems.length != 0)
                ? tablaProductos()
                : Container(
                    child: new Column(
                      children: [
                        Text(
                          "Tabla vacia",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Icon(
                          Icons.list,
                          size: 200,
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 80),
            Container(
              child: botonesBusquedaWidget(context, idSucursal, idDeposito),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  Widget tablaProductos() {
    return Container(
      child: DataTable(
        columnSpacing: 10, horizontalMargin: 10.0,

        //columnSpacing: 1.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Codigo',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Nombre',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Cantidad',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Acciones',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: listaItems
            .map(
              (item) => DataRow(
                selected: items.contains(item),
                cells: [
                  DataCell(
                    Text(item.id.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(item.name),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(item.quantity.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.mode_edit,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Style.Colors.cancelColor,
                          ),
                          onPressed: () {
                            _showMaterialDialogBorrarProducto(item);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget botonesBusquedaWidget(BuildContext context, idSucursal, idDeposito) {
    User unUsuario;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.height * 0.1),
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    Style.Shapes.botonGrandeRoundedRectangleBorder()),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Style.Colors.cancelColor2)),
            onPressed: () {
              _showMaterialDialogCancelar(
                  context, unUsuario, idSucursal, idDeposito);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
                Text('Cancelar', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.height * 0.1),
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    Style.Shapes.botonGrandeRoundedRectangleBorder()),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Style.Colors.acceptColor2)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopUpObservation(
                    context, unUsuario, idSucursal, idDeposito),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                ),
                Text('Aceptar', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showMaterialDialogAceptar(context, unUsuario, idSucursal, idDeposito) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title:
                  new Text("Se guardo correctamente el control de inventario"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: TextButton(
                      child: Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Style.Colors.acceptColor2,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(
                                unUsuario, idSucursal, idDeposito)));
                  },
                )
              ],
            ));
  }

  _showMaterialDialogCancelar(context, unUsuario, idSucursal, idUsuario) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "¿Seguro desea cancelar el control? Perderá los datos no guardados"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Si'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(
                                unUsuario, idSucursal, idDeposito)));
                  },
                ),
              ],
            ));
  }

  _showMaterialDialogBorrarProducto(Item item) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('¿Seguro desea eliminar el item?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Si'),
                  onPressed: () {
                    listaItems.removeWhere((itemBorrar) => itemBorrar == item);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            ));
  }

  Widget _buildPopUpObservation(context, unUsuario, idSucursal, idUsuario) {
    String valueText;

    return new AlertDialog(
      title: const Text('Ingrese una observación'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            maxLength: 500,
            onChanged: (value) {
              setState(() {
                valueText = value;
                codeDialog = valueText;
              });
            },
            controller: _textFieldController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ingrese nueva observación',
            ),
            autofocus: false,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Style.Colors.acceptColor2)),
          child: Text(
            'Aceptar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            //Repository().postNuevaAuditoriaStock(listaItems, codeDialog);
            Repository().postNuevaAuditoriaStock(listaItems, codeDialog);
            setState(() {
              _showMaterialDialogAceptar(
                  context, unUsuario, idSucursal, idDeposito);
            });
          },
        )
      ],
    );
  }

  Widget _buildSearchButtons() {
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
              items = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      BusquedaProductosControlScreen(listaProductos),
                ),
              );
              items.forEach((item) {
                listaItems.add(item);
              });
              setState(() {});
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
        )
      ],
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      if (barcodeScanRes != '-1') {
        final respuesta = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
                barcodeScanRes, 'busquedaCamaraControl', listaRazones),
          ),
        );
        Item unItem = new Item();
        unItem = respuesta;
        unItem.reasons = [];
        print(unItem.id);
        listaItems.add(unItem);
      }
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

      if (barcodeScanRes != '-1') {
        final respuesta = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
                barcodeScanRes, 'busquedaCamaraControl', listaRazones),
          ),
        );
        Item unItem = new Item();
        unItem = respuesta;
        print(unItem.id);
        listaItems.add(unItem);
      }
    } on PlatformException {
      barcodeScanRes = 'Fallo al obtener la version de la plataforma.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}

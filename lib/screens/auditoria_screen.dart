import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/auditoria_items_detalle.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/screens/busqueda_productos_auditoria.dart';

// ignore: must_be_immutable
class AuditoriaScreen extends StatefulWidget {
  String idSucursal;
  String idDeposito;
  List<Product> listaProductos;
  List<Reason> listaRazones;
  List<Item> listaItems;

  AuditoriaScreen(this.listaProductos, this.listaRazones, this.listaItems,
      this.idSucursal, this.idDeposito);
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState(
      this.listaProductos,
      this.listaRazones,
      this.listaItems,
      this.idSucursal,
      this.idDeposito);
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  String idSucursal;
  String idDeposito;
  List<Product> listaProductos;
  List<Reason> listaRazones;
  List<Item> listaItems;
  String dropdownValue;
  List<Item> items = [];

  // ignore: unused_field
  String _scanBarcode = 'Desconocido';

  _AuditoriaScreenState(this.listaProductos, this.listaRazones, this.listaItems,
      this.idSucursal, this.idDeposito);

  String codeDialog = '';

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idSucursal = this.idSucursal;
    idDeposito = this.idDeposito;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Auditoria'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildSearchButtons(),
            SizedBox(height: 30),
            tablaProductos(),
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
              'Observación',
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
                    Text(item.reasons[0].observations),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            popUpReasons(context, item),
                      );
                    },
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget popUpReasons(BuildContext context, Item unItem) {
    List<Reason> razonesItem = unItem.reasons;
    String valueText;
    dropdownValue = listaRazones[0].descripcion;

    List<String> nombreRazones =
        listaRazones.map((razon) => razon.descripcion).toList();
    String id = listaRazones[0].id;
    String descripcion = dropdownValue;
    String observacion = 'No aplica';
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Observaciones'),
        content: new Column(
          children: [
            SingleChildScrollView(
              child: DataTable(
                columnSpacing: 10,
                horizontalMargin: 10.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Observación',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: razonesItem
                    .map(
                      (razon) => DataRow(
                          // selected: selectedProducts.contains(producto),
                          // onSelectChanged: (b) {
                          //   onSelectedRow(b, producto);
                          // },
                          cells: [
                            DataCell(
                              Text(razon.id.toString()),
                            ),
                            DataCell(
                              Container(
                                width: 230,
                                child: Text(
                                  razon.observations,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ]),
                    )
                    .toList(),
              ),
            ),
            Column(
              children: [
                TextField(
                  maxLength: 50,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                      observacion = _textFieldController.text;
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
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Style.Colors.secondColor,
                  ),
                  onChanged: (String newValue) {
                    dropdownValue = newValue;
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: nombreRazones
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Style.Colors.cancelColor2),
                      ),
                      child: Text('Cancelar'),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Style.Colors.acceptColor),
                      ),
                      child: Text('Aceptar'),
                      onPressed: () {
                        Reason unaRazon = new Reason();
                        unaRazon.id = id;
                        unaRazon.descripcion = descripcion;
                        unaRazon.observations = observacion;
                        unItem.reasons.add(unaRazon);
                        setState(() {
                          codeDialog = valueText;
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Style.Colors.mainColor)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        GroupListViewDemo(listaItems),
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
                Text('Ver detalle', style: TextStyle(color: Colors.white)),
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

  //Zona widgets

  _showMaterialDialogAceptar(context, unUsuario, idSucursal, idDeposito) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "Se guardo correctamente la auditoria de gondola N°"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Repository()
                        .postNuevaAuditoriaGondola(listaItems, codeDialog);
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
                  "¿Seguro desea cancelar la auditoria? Perderá los datos no guardados"),
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

  Widget _buildPopUpObservation(
      BuildContext context, unUsuario, idSucursal, idDeposito) {
    String valueText;

    return new AlertDialog(
      title: const Text('Ingrese una observación'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Observación'),
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
            setState(() {
              codeDialog = valueText;
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Style.Colors.mainColor)),
            onPressed: () async {
              items = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      BusquedaProductosAuditoriaScreen(
                          listaRazones, listaProductos),
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
            //onPressed: () => scanBarcodeNormal(),
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
}

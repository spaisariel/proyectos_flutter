import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/auditoria_items_detalle.dart';
import 'package:prueba3_git/screens/product_screen.dart';
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
  List<Item> listaItems = [];
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
        title: FittedBox(
          child: Text('Auditoria'),
        ),
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
                          size: 150,
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 80),
            Container(
              child: botonesControlAuditoria(context, idSucursal, idDeposito),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  Widget tablaProductos() {
    return Container(
      child: FittedBox(
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 10.0,
          dataRowHeight: 60,
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
                      Container(
                        width: 200,
                        child: Text(item.name),
                      ),
                      onTap: () {},
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.mode_edit,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    popUpReasons(context, item),
                              );
                            },
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
      ),
    );
  }

  Widget botonesControlAuditoria(BuildContext context, idSucursal, idDeposito) {
    double fuenteBotonControlAuditoria = 0.05;
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
            child: FittedBox(
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
                  Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonControlAuditoria),
                  ),
                ],
              ),
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
            child: FittedBox(
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
                  Text(
                    'Detalle',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonControlAuditoria),
                  ),
                ],
              ),
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
            child: FittedBox(
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
                  Text(
                    'Aceptar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonControlAuditoria),
                  ),
                ],
              ),
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
                  new Text("Se guardó correctamente la auditoria de gondola"),
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.acceptColor2),
                  ),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Style.Colors.blanco),
                  ),
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
            "¿Seguro desea cancelar la auditoria? Perderá los datos no guardados"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.cancelColor2)),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.acceptColor2)),
                  child: Text(
                    'Si',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(
                                unUsuario, idSucursal, idDeposito)));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showMaterialDialogBorrarProducto(Item item) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('¿Seguro desea eliminar el item?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.cancelColor2)),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.acceptColor2)),
                  child: Text(
                    'Si',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    listaItems.removeWhere((itemBorrar) => itemBorrar == item);
                    Navigator.pop(context);
                    setState(() {});
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showMaterialDialogBorrarObservacion(
      Reason razon, List<Reason> razonesItem, Item unItem) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('¿Seguro desea eliminar la observación?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.cancelColor2)),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Style.Colors.acceptColor2)),
                  child: Text(
                    'Si',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    razonesItem
                        .removeWhere((razonBorrar) => razonBorrar == razon);
                    Navigator.pop(context);
                    popUpReasons(context, unItem);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopUpObservation(
      BuildContext context, unUsuario, idSucursal, idDeposito) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.cancelColor2)),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.acceptColor2)),
                child: FittedBox(
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Repository()
                      .postNuevaAuditoriaGondola(listaItems, codeDialog);
                  setState(() {
                    _showMaterialDialogAceptar(
                        context, unUsuario, idSucursal, idDeposito);
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButtons() {
    double fuenteBotonChico = 0.05;
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
            child: FittedBox(
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
                  Text(
                    'Manual',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonChico),
                  ),
                ],
              ),
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
            onPressed: () => scanQR(listaRazones),
            child: FittedBox(
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
            onPressed: () => scanBarcodeNormal(),
            child: FittedBox(
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
        )
      ],
    );
  }

  Future<void> scanQR(listaRazones) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.QR);
      //print(barcodeScanRes);

      if (barcodeScanRes != '-1') {
        final respuesta = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductScreen(barcodeScanRes, 'busquedaCamara', listaRazones),
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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      if (barcodeScanRes != '-1') {
        final respuesta = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductScreen(barcodeScanRes, 'busquedaCamara', listaRazones),
          ),
        );
        Item unItem = new Item();
        unItem = respuesta;
        print(unItem.id);
        listaItems.add(unItem);
      }

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

  Widget popUpReasons(BuildContext context, Item unItem) {
    List<Reason> razonesItem = unItem.reasons;
    String valueText;
    dropdownValue = listaRazones[0].descripcion;
    _textFieldController.clear();

    List<String> nombreRazones =
        listaRazones.map((razon) => razon.descripcion).toList();
    String id = listaRazones[0].id;
    String descripcion = dropdownValue;
    String observacion = 'No aplica';
    return StatefulBuilder(builder: (context, setState) {
      return SingleChildScrollView(
        child: Container(
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            title: const Text('Observaciones'),
            content: new Column(
              children: [
                SingleChildScrollView(
                  child: FittedBox(
                    child: DataTable(
                      columnSpacing: 25,
                      horizontalMargin: 10.0,
                      columns: const <DataColumn>[
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
                        DataColumn(
                          label: Text(
                            'Acciones',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: razonesItem
                          .map(
                            (razon) => DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: 80,
                                    child: Text(
                                      razon.descripcion,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 100,
                                    child: Text(
                                      razon.observations,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Style.Colors.cancelColor,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _showMaterialDialogBorrarObservacion(
                                              razon, razonesItem, unItem);
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
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      maxLength: 500,
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
                        setState(() {
                          dropdownValue = newValue;
                          descripcion = dropdownValue;
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
          ),
        ),
      );
    });
  }
}

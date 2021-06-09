import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product_info.dart';
import 'package:prueba3_git/models/product_info_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  final String idValue;
  final String busqueda;
  List<Reason> listaRazones = [];
  ProductScreen(this.idValue, this.busqueda, this.listaRazones);
  @override
  _ProductScreenState createState() =>
      _ProductScreenState(this.idValue, this.busqueda, this.listaRazones);
}

class _ProductScreenState extends State<ProductScreen> {
  final String idValue;
  final String busqueda;
  List<Reason> listaRazones = [];
  Item unItemPrueba = new Item();

  _ProductScreenState(this.idValue, this.busqueda, this.listaRazones);

  String dropdownValue;
  List<Reason> selectedReasons = [];
  List<Item> listaItems = [];
  String codeDialog = '';

  bool muestra = false;
  bool construccionPantalla = false;
  String id = 'Error';
  String descripcion = 'No aplica';
  String observacion = 'No aplica';

  int cantStock;

  TextEditingController hintController = new TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Repository().getProduct(idValue),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return errorProducto();
            } else {
              return _buildHomeWidget(snapshot.data);
            }
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget errorProducto() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Articulo inexistente'),
      ),
    );
    return null;
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
        ),
      ],
    ));
  }

  Widget _buildHomeWidget(ProductInfoResponse data) {
    ProductInfo unProducto = data.product;
    List<Stock> stockProducto = data.product.stocks;
    List<Price> listaPrecios = data.product.prices;

    List<String> imgListItem = [];

    // unProducto.images.forEach((image) {
    //   imgListItem.add(image);
    // });

    final List<String> imgList = [
      // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    final GlobalKey<ExpansionTileCardState> cardPrincipal = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardPrecios = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardExistencias = new GlobalKey();

    String descripcionProducto = unProducto.descripcion;
    if (descripcionProducto == null) {
      descripcionProducto = 'No tiene';
    }

    String codigoProveedorHabitual = unProducto.codigoProveedorHabitual;
    if (codigoProveedorHabitual == null) {
      codigoProveedorHabitual = 'No tiene';
    }

    String codigoPresentacionVenta = unProducto.codigoPresentacionVenta;
    if (codigoPresentacionVenta == null) {
      codigoPresentacionVenta = 'No tiene';
    }

    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: FittedBox(
          child: Text(
            unProducto.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Image.network(unProducto.image),
            CarouselSlider(
              options: CarouselOptions(
                //height: 200.0,
                aspectRatio: 16 / 9,
                scrollDirection: Axis.horizontal,
              ),
              //En un futuro, cuando producto tenga varias imagenes, descomentar
              //esta linea y borrar la de abajo
              //items: imgListItem
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.network(item,
                                fit: BoxFit.cover, width: 1000)),
                      ))
                  .toList(),
            ),

            ExpansionTileCard(
              initiallyExpanded: true,
              baseColor: Style.Colors.blanco,
              expandedColor: Colors.grey,
              key: cardPrincipal,
              leading: CircleAvatar(child: Icon(Icons.description)),
              title: Text(
                "Datos principales",
                style: TextStyle(color: Colors.black),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          runSpacing: 20,
                          spacing: 100,
                          children: [
                            RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Nombre: '),
                                      TextSpan(
                                          text: unProducto.name,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ])),
                            RichText(
                                text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Codigo articulo: '),
                                  TextSpan(
                                      text: unProducto.id.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Codigo interno: '),
                                  TextSpan(
                                      text: unProducto.internalCode,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Codigo del proveedor: '),
                                  TextSpan(
                                      text: codigoProveedorHabitual,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                  (listaRazones != null)
                                      ? TextSpan(
                                          text: 'Presentacion para la venta: ')
                                      : TextSpan(
                                          text: 'Presentacion para stock: '),
                                  TextSpan(
                                      text: codigoPresentacionVenta,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            ExpansionTileCard(
              baseColor: Style.Colors.blanco,
              expandedColor: Colors.grey,
              key: cardExistencias,
              leading: CircleAvatar(child: Icon(Icons.attach_money)),
              title: Text(
                "Precios",
                style: TextStyle(color: Colors.black),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        FittedBox(
                          child: DataTable(
                            columnSpacing: 10,
                            horizontalMargin: 10.0,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Presentación',
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
                                  'Precio',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Moneda',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                            rows: listaPrecios
                                .map(
                                  (precios) => DataRow(cells: [
                                    DataCell(
                                      Text(precios.presentation),
                                    ),
                                    DataCell(
                                      Text(
                                        precios.priceName,
                                      ),
                                    ),
                                    DataCell(
                                      Text(precios.price.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        precios.currency,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            ExpansionTileCard(
              baseColor: Style.Colors.blanco,
              expandedColor: Colors.grey,
              key: cardPrecios,
              leading: CircleAvatar(child: Icon(Icons.inventory)),
              title: Text(
                "Existencias",
                style: TextStyle(color: Colors.black),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        FittedBox(
                          child: DataTable(
                            columnSpacing: 10,
                            horizontalMargin: 10.0,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Presentacion',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Deposito',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Sucursal',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Existencias',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                            rows: stockProducto
                                .map(
                                  (producto) => DataRow(cells: [
                                    DataCell(
                                      Text(producto.presentationName),
                                    ),
                                    DataCell(
                                      Text(
                                        producto.depositName,
                                      ),
                                    ),
                                    DataCell(
                                      Text(producto.branchOfficeName),
                                    ),
                                    DataCell(
                                      Text(producto.quantity.toString()),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            if (busqueda == 'busquedaCamaraControl')
              agregarItemAuditoria(unProducto),
            if (busqueda == 'busquedaCamara')
              popUpObservation(context, unProducto),
            if (muestra == true) popUpObservation(context, unProducto),
          ],
        ),
      ),
    );
  }

  Widget agregarItemAuditoria(ProductInfo unProducto) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Column(children: [
              TextField(
                maxLength: 4,
                onChanged: (value) {
                  setState(() {
                    cantStock = int.parse(value);
                  });
                },
                controller: _textFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese la cantidad en stock',
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.mainColor),
                    shape: MaterialStateProperty.all(
                        Style.Shapes.botonGrandeRoundedRectangleBorder())),
                child: FittedBox(
                  child: Text('Agregar a la auditoria',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                onPressed: () {
                  unProducto.existenciaUnidades = cantStock;
                  (listaRazones != null)
                      ? muestra = true
                      : _agregarProductoAControl(unProducto);
                  setState(() {});
                },
              ),
            ]));
      },
    );
  }

  _agregarProductoAControl(ProductInfo unProducto) {
    Item unItem = new Item();
    unItem.id = int.parse(unProducto.internalCode);
    unItem.productId = unProducto.id;
    unItem.name = unProducto.name;
    unItem.quantity = unProducto.existenciaUnidades.toDouble();
    unItem.presentationId = unProducto.codigoPresentacionVenta;
    listaItems.add(unItem);
    setState(() {
      muestra = false;
      Navigator.pop(context, unItem);
    });
  }

  Widget popUpObservation(BuildContext context, ProductInfo unProducto) {
    String valueText;
    dropdownValue = listaRazones[0].descripcion;
    Item unItem = new Item();
    unItem.id = int.parse(unProducto.internalCode);
    unItem.productId = unProducto.id;
    unItem.name = unProducto.name;
    unItem.quantity = unProducto.existenciaUnidades.toDouble();

    String id = listaRazones[0].id;
    String descripcion = dropdownValue;
    String observacion = 'No aplica';

    List<String> nombreRazones =
        listaRazones.map((razon) => razon.descripcion).toList();
    return StatefulBuilder(builder: (context, setState) {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
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
                    listaRazones.forEach((item) {
                      if (item.descripcion == descripcion) {
                        id = item.id;
                      }
                    });
                  });
                },
                items:
                    nombreRazones.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    width: 50,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Style.Colors.acceptColor2)),
                    child: Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Reason unaRazon = new Reason();
                      unaRazon.id = id;
                      unaRazon.descripcion = descripcion;
                      unaRazon.observations = observacion;
                      selectedReasons.add(unaRazon);
                      unItem.reasons = [];
                      unItem.reasons.add(unaRazon);
                      listaItems.add(unItem);
                      setState(() {
                        muestra = false;
                        codeDialog = valueText;
                        Navigator.pop(context, unItem);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

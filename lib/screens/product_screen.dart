import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_info_bloc.dart';
import 'package:prueba3_git/models/product_info.dart';
import 'package:prueba3_git/models/product_info_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class ProductScreen extends StatefulWidget {
  final String idValue;
  final String name;
  final String image;
  ProductScreen(this.idValue, this.name, this.image);
  @override
  _ProductScreenState createState() =>
      _ProductScreenState(this.idValue, this.name, this.image);
}

class _ProductScreenState extends State<ProductScreen> {
  final String idValue;
  final String name;
  final String image;
  _ProductScreenState(this.idValue, this.name, this.image);

  @override
  void initState() {
    super.initState();
    productInfoBloc..getProduct(this.idValue);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductInfoResponse>(
      stream: productInfoBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductInfoResponse> snapshot) {
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

  Widget _buildHomeWidget(ProductInfoResponse data) {
    ProductInfo unProducto = data.products[0];
    List<Stock> stockProducto = data.products[0].stocks;

    String descripcionProducto;
    if (descripcionProducto == null) {
      descripcionProducto = 'No tiene';
    } else {
      descripcionProducto = unProducto.descripcion;
    }

    String codigoProveedorHabitual;
    if (codigoProveedorHabitual == null) {
      codigoProveedorHabitual = 'No tiene';
    } else {
      codigoProveedorHabitual = unProducto.codigoProveedorHabitual;
    }

    String codigoPresentacionVenta;
    if (codigoPresentacionVenta == null) {
      codigoPresentacionVenta = 'No tiene';
    } else {
      codigoPresentacionVenta = unProducto.codigoPresentacionVenta;
    }

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Style.Colors.secondColor,
            appBar: AppBar(
              backgroundColor: Style.Colors.mainColor,
              title: Text(name),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Image.network(image),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      "Datos principales",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Codigo articulo: ' + unProducto.id.toString(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Codigo articulo: ' + unProducto.internalCode,
                        ),
                      ),
                      ListTile(
                        title: Text(
                            'Codigo del proveedor: ' + codigoProveedorHabitual),
                      ),
                      ListTile(
                        title: Text('Presentacion para venta: ' +
                            codigoPresentacionVenta),
                      ),
                      ListTile(
                        title: Text('Existencia unidades: ' +
                            unProducto.existenciaUnidades.toString()),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Precios",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Por presentacion: ' +
                              unProducto.precioPorPresentacion.toString(),
                        ),
                      ),
                      ListTile(
                        title: Text('Por lista: ' +
                            unProducto.precioPorLista.toString()),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Existencias",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 10.0,
                        columns: const <DataColumn>[
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
                              'Presentacion',
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
                                  Text(producto.depositName),
                                ),
                                DataCell(
                                  Text(
                                    producto.branchOfficeName,
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(producto.presentationName),
                                ),
                                DataCell(
                                  Text(producto.quantity.toString()),
                                ),
                              ]),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ],
              ),
            ))));
  }
}

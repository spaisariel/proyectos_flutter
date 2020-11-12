import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    productListBloc..getProductLista();
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
    Product unProducto = data.products[0];
    // ignore: unused_local_variable
    List<Product> productoSucursal = data.products;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Style.Colors.secondColor,
            appBar: AppBar(
              backgroundColor: Style.Colors.mainColor,
              title: Text('Producto'),
              centerTitle: true,
            ),
            //     Expanded(
            //       child: Align(
            //         alignment: Alignment.bottomCenter,
            //         child: RaisedButton(
            //             color: Style.Colors.cancelColor,
            //             shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            //             onPressed: () {},
            //             child: Text(
            //               'Quitar de la lista',
            //               style: TextStyle(color: Colors.white, fontSize: 20),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),

            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ExpansionTile(
                      title: Text(
                        "Datos principales",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Codigo: ' + unProducto.idCodigo.toString(),
                          ),
                        ),
                        ListTile(
                          title: Text('Descripcion: ' + unProducto.descripcion),
                        ),
                        ListTile(
                          title: Text(
                              'Unidad por bulto: ' + unProducto.unidadPorBulto),
                        ),
                        ListTile(
                          title: Text('Costo: ${unProducto.costo}'),
                        ),
                        ListTile(
                          title: Text(
                              'Existencia unidades: ' + unProducto.existencia),
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
                                unProducto.precioPresentacion,
                          ),
                        ),
                        ListTile(
                          title: Text('Por lista: ' + unProducto.precioLista),
                        ),
                      ],
                    ),
                    // ExpansionTile(
                    //   title: Text(
                    //     "Existencias",
                    //     style: TextStyle(
                    //         fontSize: 18.0, fontWeight: FontWeight.bold),
                    //   ),
                    //   children: <Widget>[
                    //     DataTable(
                    //       columnSpacing: 10,
                    //       horizontalMargin: 10.0,

                    //       //columnSpacing: 1.0,
                    //       columns: const <DataColumn>[
                    //         DataColumn(
                    //           label: Text(
                    //             'ID',
                    //             style: TextStyle(fontStyle: FontStyle.italic),
                    //           ),
                    //         ),
                    //         DataColumn(
                    //           label: Text(
                    //             'NOMBRE',
                    //             style: TextStyle(fontStyle: FontStyle.italic),
                    //           ),
                    //         ),
                    //         DataColumn(
                    //           label: Text(
                    //             'EMAIL',
                    //             style: TextStyle(fontStyle: FontStyle.italic),
                    //           ),
                    //         ),
                    //         DataColumn(
                    //           label: Text(
                    //             'DESCRIPCION',
                    //             style: TextStyle(fontStyle: FontStyle.italic),
                    //           ),
                    //         )
                    //       ],

                    //       //Falta agregar las filas.

                    //       // rows: [
                    //       //   DataRow(
                    //       //       cells: DataCell(
                    //       //     Text(productoSucursal
                    //       //         .existenciaDepositos.deposito),
                    //       //   ))
                    //       // ],
                    //       // rows: productoSucursal.take(5).map(
                    //       //       (productoSucursal) => DataRow(
                    //       //         selected: productoSucursal
                    //       //             .contains(productoSucursal),
                    //       //         cells: [
                    //       //           DataCell(
                    //       //             Text(productoSucursal
                    //       //                 .existenciaDepositos.deposito),
                    //       //             onTap: () {
                    //       //               // write your code..
                    //       //               // MaterialPageRoute(
                    //       //               //   builder: (context) => ProductScreen(unProducto),
                    //       //               // );
                    //       //             },
                    //       //           ),
                    //       //           DataCell(
                    //       //             Text(
                    //       //               productoSucursal
                    //       //                   .existenciaDepositos.sucursal,
                    //       //               //overflow: TextOverflow.ellipsis,
                    //       //             ),
                    //       //           ),
                    //       //           DataCell(
                    //       //             Text(
                    //       //               productoSucursal.existenciaDepositos
                    //       //                   .existenciaOtroLugar,
                    //       //               //overflow: TextOverflow.ellipsis,
                    //       //             ),
                    //       //           ),
                    //       //           DataCell(
                    //       //             Text(
                    //       //               productoSucursal
                    //       //                   .existenciaDepositos.presentacion,
                    //       //               //overflow: TextOverflow.ellipsis,
                    //       //             ),
                    //       //           )
                    //       //         ],
                    //       //       ),
                    //       //     ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ))));
  }
}

class FiltroWidget extends StatefulWidget {
  final List<Product> albums;
  FiltroWidget(this.albums);

  @override
  _FiltroWidgetState createState() => _FiltroWidgetState(this.albums);
}

class _FiltroWidgetState extends State<FiltroWidget> {
  final List<Product> albums;
  _FiltroWidgetState(this.albums);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        color: Style.Colors.secondColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              child: Text('Filtro'),
              onPressed: () {},
            )
          ],
        ));
  }
}

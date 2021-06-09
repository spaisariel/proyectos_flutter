import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class BusquedaManualScreen extends StatefulWidget {
  BusquedaManualScreen({Key key}) : super(key: key);

  @override
  _BusquedaManualScreenState createState() => _BusquedaManualScreenState();
}

class _BusquedaManualScreenState extends State<BusquedaManualScreen> {
  ScrollController _scrollController = ScrollController();

  List<bool> filtrosSeleccionados;
  int cantProductos;
  Product filtroSeleccionado;
  Product unProducto;
  String idValue;
  String hint = '';
  String begin = '0';
  String end = '15';
  List<Reason> listaRazones = [];

  TextEditingController hintController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    productListBloc..getProductLista(hint, begin, end);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        end = (cantProductos + 30).toString();
        setState(() {
          productListBloc..getProductLista(hintController.text, begin, end);
        });
      }
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
    List<Product> productos = data.products;
    cantProductos = data.products.length;

    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: FittedBox(
          child: Text('Busqueda manual'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: hintController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese nombre o codigo',
                      ),
                      onSaved: (String valor) {},
                    )),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        productListBloc
                          ..getProductLista(hintController.text, begin, end);
                      });
                    })
              ],
            ),
            tablaProductos(productos)
          ],
        ),
      ),
    );
  }

  Widget tablaProductos(List<Product> productos) {
    return FittedBox(
      child: Container(
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 10.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Codigo',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Descripción',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Foto',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: productos
              .map(
                (producto) => DataRow(
                    //selected: productos.contains(producto),
                    cells: [
                      DataCell(
                        Container(
                          width: 40,
                          child: Text(
                            producto.id.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          width: 250,
                          child: Text(
                            producto.name,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                            width: 60, child: Image.network(producto.image)),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                producto.id.toString(),
                                '',
                                listaRazones,
                              ),
                            )),
                      ),
                    ]),
              )
              .toList(),
        ),
        // child: DataTable(
        //   columnSpacing: 10,
        //   horizontalMargin: 10.0,
        //   columns: [
        //     DataColumn(
        //       label: Text(
        //         'Codigo',
        //         style: TextStyle(fontStyle: FontStyle.italic),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'Descripción',
        //         style: TextStyle(fontStyle: FontStyle.italic),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'Foto',
        //         style: TextStyle(fontStyle: FontStyle.italic),
        //       ),
        //     ),
        //   ],
        //   rows: productos
        //       .map(
        //         (producto) =>
        //             DataRow(selected: productos.contains(producto), cells: [
        //           DataCell(
        //             Container(
        //               width: 40,
        //               child: Text(
        //                 producto.id.toString(),
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ),
        //           ),
        //           DataCell(
        //             Container(
        //               width: 260,
        //               child: Text(
        //                 producto.name,
        //                 overflow: TextOverflow.clip,
        //               ),
        //             ),
        //           ),
        //           DataCell(
        //             Container(child: Image.network(producto.image)),
        //             onTap: () => Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => ProductScreen(
        //                     producto.id.toString(),
        //                     '',
        //                     listaRazones,
        //                   ),
        //                 )),
        //           ),
        //         ]),
        //       )
        //       .toList(),
        // ),
      ),
    );
  }
}

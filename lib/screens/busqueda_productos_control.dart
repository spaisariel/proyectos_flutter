import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
//import 'package:prueba3_git/screens/control_inventario_screen.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

// ignore: must_be_immutable
class BusquedaProductosControlScreen extends StatefulWidget {
  List<Product> listaProductos;

  BusquedaProductosControlScreen(this.listaProductos);

  @override
  _BusquedaProductosControlScreenState createState() =>
      _BusquedaProductosControlScreenState(this.listaProductos);
}

class _BusquedaProductosControlScreenState
    extends State<BusquedaProductosControlScreen> {
  List<bool> filtrosSeleccionados;
  Product filtroSeleccionado;
  Product unProducto;
  int cantProductos;
  String idValue;
  String hint = '';
  String begin = '0';
  String end = '15';
  String codeDialog = '';
  List<Product> selectedProducts;
  List<Product> listaProductos = [];
  List<Item> listaItems = [];

  _BusquedaProductosControlScreenState(this.listaProductos);

  TextEditingController hintController = new TextEditingController();
  //TextEditingController _textFieldController = TextEditingController();
  ScrollController _scrollController = ScrollController();

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
    selectedProducts = [];
  }

  onSelectedRow(bool selected, Product unProducto) async {
    setState(() {
      if (selected) {
        unProducto.observation = codeDialog;
        selectedProducts.add(unProducto);
        Item unItem = new Item();
        unItem.id = int.parse(unProducto.internalCode);
        unItem.productId = unProducto.id;
        unItem.name = unProducto.name;
        unItem.quantity = unProducto.stock;
        listaItems.add(unItem);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) =>
        //       _buildPopUpObservation(context, unItem),
        // );
      } else {
        unProducto.observation = '';
        selectedProducts.remove(unProducto);
      }
    });
    // setState(() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => _buildPopUpObservation(context, unItem),
    //   );
    //   if (selected) {
    //     unProducto.observation = codeDialog;
    //     selectedProducts.add(unProducto);
    //   } else {
    //     unProducto.observation = '';
    //     selectedProducts.remove(unProducto);
    //   }
    // });
  }

  //VER BIEN FUNCIONAMIENTO DE ESTE METODO
  deleteSelected() async {
    setState(() {
      if (selectedProducts.isNotEmpty) {
        List<Product> temp = [];
        temp.addAll(selectedProducts);
        for (Product p in temp) {
          selectedProducts.remove(p);
        }
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
      backgroundColor: Style.Colors.blanco,
      // appBar: AppBar(
      //   backgroundColor: Style.Colors.mainColor,
      //   title: Text('Busqueda manual'),
      //   actions: <Widget>[
      //     Padding(
      //         padding: EdgeInsets.only(right: 20.0),
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) =>
      //                     ControlInventarioScreen(selectedProducts, '', ''),
      //               ),
      //             );
      //           },
      //           child: Icon(
      //             Icons.check,
      //             size: 26.0,
      //           ),
      //         )),
      //   ],
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, listaItems),
            );
          },
        ),
        title: Text('Busqueda manual'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("Cantidad: " + listaItems.length.toString()),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            Container(
              child: DataTable(
                horizontalMargin: 10.0,
                showCheckboxColumn: true,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'CODIGO',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOMBRE',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'FOTO',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: productos
                    .map(
                      (producto) => DataRow(
                          selected: selectedProducts.contains(producto),
                          onSelectChanged: (b) {
                            onSelectedRow(b, producto);
                          },
                          cells: [
                            DataCell(
                              Container(
                                  width: 50,
                                  child: Text(producto.id.toString())),
                              // onTap: () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductScreen(
                              //       producto.id.toString(),
                              //       producto.name,
                              //       producto.image,
                              //     ),
                              //   ),
                              // ),
                            ),
                            DataCell(
                              Text(
                                producto.name,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            DataCell(
                              Container(child: Image.network(producto.image)),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    producto.id.toString(),
                                    producto.name,
                                    producto.image,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            // ButtonTheme(
            //   buttonColor: Style.Colors.mainColor,
            //   height: MediaQuery.of(context).size.height * 0.1,
            //   minWidth: MediaQuery.of(context).size.width * 0.8,
            //   child: ElevatedButton.icon(
            //       style: ElevatedButton.styleFrom(
            //         shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 ControlInventarioScreen(selectedProducts, '', ''),
            //           ),
            //         );
            //       },
            //       icon: Icon(Icons.assignment,
            //           size: 40, color: Style.Colors.secondColor),
            //       label: Text(
            //         'Agregar a control',
            //         style: TextStyle(color: Colors.white, fontSize: 20),
            //       )),
            // )
          ],
        ),
      ),
    );
  }

  // Widget _buildPopUpObservation(BuildContext context, Item unItem) {
  //   String valueText;

  //   return new AlertDialog(
  //     title: const Text('Ingrese una observación'),
  //     content: new Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         TextField(
  //           onChanged: (value) {
  //             setState(() {
  //               valueText = value;
  //             });
  //           },
  //           controller: _textFieldController,
  //           decoration: InputDecoration(
  //               border: InputBorder.none, hintText: 'Observación'),
  //         ),
  //       ],
  //     ),
  //     actions: <Widget>[
  //       TextButton(
  //         style: ButtonStyle(
  //             backgroundColor:
  //                 MaterialStateProperty.all<Color>(Style.Colors.acceptColor2)),
  //         child: Text(
  //           'Aceptar',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             codeDialog = valueText;
  //             Navigator.pop(context);
  //           });
  //         },
  //       )
  //     ],
  //   );
  // }
}

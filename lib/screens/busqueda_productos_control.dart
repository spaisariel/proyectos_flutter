import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
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
  List<Product> selectedProducts = [];
  List<Product> listaProductos = [];
  List<Item> listaItems = [];
  List<Reason> listaRazones = [];
  double cantStock;

  _BusquedaProductosControlScreenState(this.listaProductos);

  TextEditingController hintController = new TextEditingController();
  TextEditingController _textFieldController = TextEditingController();
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
        selectedProducts.add(unProducto);
        Item unItem = new Item();
        unItem.id = int.parse(unProducto.internalCode);
        unItem.productId = unProducto.id;
        unItem.name = unProducto.name;
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildPopUpQuantity(context, unItem),
        );
      } else {
        selectedProducts.remove(unProducto);
        listaItems.removeWhere(
            (item) => item.id == int.parse(unProducto.internalCode));
      }
    });
  }

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
      backgroundColor: Style.Colors.secondColor,
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
        title: FittedBox(
          child: Text('Busqueda manual'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: FittedBox(
              child: Text(
                "Cantidad: " + listaItems.length.toString(),
              ),
            ),
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
                      onChanged: (String valor) {
                        if (valor.length > 2) {
                          setState(() {
                            productListBloc
                              ..getProductLista(
                                  hintController.text, begin, end);
                          });
                        }
                      },
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
            tablaProductos(productos),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget tablaProductos(List<Product> productos) {
    return FittedBox(
      child: Container(
        child: DataTable(
          showCheckboxColumn: false,
          columnSpacing: 10,
          horizontalMargin: 10.0,
          dataRowHeight: 75,
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
                'Foto',
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
                          width: 60,
                          child: Image.network(producto.image),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              producto.id.toString(),
                              '',
                              listaRazones,
                            ),
                          ),
                        ),
                      ),
                    ]),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPopUpQuantity(context, Item unItem) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Ingrese el stock'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLength: 4,
                onChanged: (value) {
                  setState(() {
                    cantStock = double.parse(value);
                  });
                },
                controller: _textFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese cantidad en stock',
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
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
                      unItem.quantity = cantStock;
                      unItem.presentationId = 'Unidad';
                      listaItems.add(unItem);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
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
                      unItem.quantity = cantStock;
                      unItem.presentationId = 'Unidad';
                      listaItems.add(unItem);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ]),
      );
    });
  }
}

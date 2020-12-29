import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/screens/auditoria_fake_screen.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/filtro_busqueda_widget.dart';

class BusquedaProductosAuditoriaScreen extends StatefulWidget {
  BusquedaProductosAuditoriaScreen({Key key}) : super(key: key);

  @override
  _BusquedaProductosAuditoriaScreenState createState() =>
      _BusquedaProductosAuditoriaScreenState();
}

class _BusquedaProductosAuditoriaScreenState
    extends State<BusquedaProductosAuditoriaScreen> {
  List<bool> filtrosSeleccionados;
  Product filtroSeleccionado;
  Product unProducto;
  String idValue;
  String hint = '';
  List<Product> selectedProducts;

  TextEditingController hintController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    productListBloc..getProductLista(hint);
    selectedProducts = [];
  }

  onSelectedRow(bool selected, Product unProducto) async {
    setState(() {
      if (selected) {
        selectedProducts.add(unProducto);
      } else {
        selectedProducts.remove(unProducto);
      }
    });
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

    if (productos.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No existen productos que coincidan con la busqueda",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: Style.Colors.blanco,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Busqueda manual'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FiltroBusquedaWidget(productos),
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
                      onSaved: (String valor) {
                        //hint = valor;
                      },
                    )),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        productListBloc..getProductLista(hintController.text);
                      });
                    })
              ],
            ),
            Container(
              child: DataTable(
                columnSpacing: 10,
                horizontalMargin: 10.0,
                showCheckboxColumn: true,
                //columnSpacing: 1.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOMBRE',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: productos
                    .take(5)
                    .map(
                      (producto) => DataRow(
                          selected: selectedProducts.contains(producto),
                          onSelectChanged: (b) {
                            //print('OnSelected');
                            onSelectedRow(b, producto);
                          },
                          cells: [
                            DataCell(
                              Text(producto.id.toString()),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    producto.id.toString(),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                producto.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 20),

            //CORREGIR ESTILO, TAMAÑO Y/O COLOR DEL BOTON DE ABAJO
            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pop(idProductos);
                    //Navigator.pop(context, idProductos);
                    //AuditoriaFakeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuditoriaFakeScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.assignment,
                      size: 40, color: Style.Colors.secondColor),
                  label: Text(
                    'Agregar a auditoria',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      );
  }
}

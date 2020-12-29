import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_auditoria_widget.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

class AuditoriaFakeScreen extends StatefulWidget {
  @override
  _AuditoriaFakeScreenState createState() => _AuditoriaFakeScreenState();
}

class _AuditoriaFakeScreenState extends State<AuditoriaFakeScreen> {
  @override
  void initState() {
    super.initState();
    productListBloc..getProductListaFake();
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

  @override
  // ignore: override_on_non_overriding_member
  Widget _buildHomeWidget(ProductResponse data) {
    // List<Product> productosAuditorias = new List();
    // List<String> idProductos = new List<String>();

    //borrar despues
    List<Product> productos = data.products;

    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Auditoria'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            BotonesBusquedaWidget(true),
            SizedBox(height: 30),
            //AuditoriaTablaWidget(),
            tablaProductos(productos),
            SizedBox(height: 80),
            Container(
              child: BotonesAuditoriaWidget(),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  Widget tablaProductos(List<Product> productos) {
    return Container(
      child: DataTable(
        columnSpacing: 10, horizontalMargin: 10.0,

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
            .map(
              (producto) => DataRow(
                selected: productos.contains(producto),
                cells: [
                  DataCell(
                    Text(producto.id.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(producto.name),
                    onTap: () {},
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

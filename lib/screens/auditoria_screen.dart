import 'package:flutter/material.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_auditoria_widget.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> productosAuditorias = new List();
    //List<String> idProductos = new List<String>();

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
            tablaProductos(productosAuditorias),
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
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

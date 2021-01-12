import 'package:flutter/material.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

// ignore: must_be_immutable
class AuditoriaScreen extends StatefulWidget {
  List<Product> listaProductos;
  AuditoriaScreen(this.listaProductos);
  @override
  _AuditoriaScreenState createState() =>
      _AuditoriaScreenState(this.listaProductos);
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  List<Product> listaProductos;
  _AuditoriaScreenState(this.listaProductos);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            BotonesBusquedaWidget("auditoria"),
            SizedBox(height: 30),
            //AuditoriaTablaWidget(),
            tablaProductos(listaProductos),
            SizedBox(height: 80),
            Container(
              child: botonesBusquedaWidget(context),
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

  Widget botonesBusquedaWidget(BuildContext context) {
    User unUsuario;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonTheme(
          buttonColor: Style.Colors.cancelColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // style: ElevatedButton.styleFrom(
              //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // ),
              onPressed: () {
                //Navigator.of(context).pop();
                _showMaterialDialogCancelar(context, unUsuario);
              },
              child: Column(
                children: [
                  Text('Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('auditoria',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        ),
        SizedBox(width: 20),
        ButtonTheme(
          buttonColor: Style.Colors.acceptColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // style: ElevatedButton.styleFrom(
              //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              // ),
              onPressed: () {
                //Navigator.of(context).pop();
                _showMaterialDialogAceptar(context, unUsuario);
              },
              child: Column(
                children: [
                  Text('Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('auditoria',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        )
      ],
    );
  }

  _showMaterialDialogAceptar(context, unUsuario) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title:
                  new Text("Se guardo correctamente la auditoria de gondola"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Repository().postNuevaAuditoria(listaProductos);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(unUsuario)));
                  },
                )
              ],
            ));
  }

  _showMaterialDialogCancelar(context, unUsuario) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "¿Seguro desea cancelar la auditoria? Perderá los datos no guardados"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Si'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(unUsuario)));
                  },
                ),
              ],
            ));
  }
}

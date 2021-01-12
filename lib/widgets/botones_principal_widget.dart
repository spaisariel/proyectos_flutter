import 'package:flutter/material.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/auditoria_screen.dart';
import 'package:prueba3_git/screens/consulta_auditoria_screen.dart';
import 'package:prueba3_git/screens/consulta_inventario_screen.dart';
import 'package:prueba3_git/screens/control_inventario_screen.dart';
import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesPrincipalWidget extends StatelessWidget {
  Product unProducto;
  Repository unRepositorio;

  @override
  Widget build(BuildContext context) {
    List<Product> listaProductos = [];
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // style: RaisedButton.styleFrom(
            //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuditoriaScreen(listaProductos),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Auditoria de gondola',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            // style: ElevatedButton.styleFrom(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0)),
            // ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ControlInventarioScreen(listaProductos),
                  //builder: (context) => ProductScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.assignment_turned_in,
              color: Style.Colors.secondColor,
              size: 40,
            ),
            label: Text('Control de inventario',
                style: TextStyle(color: Colors.white, fontSize: 20))),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // style: ElevatedButton.styleFrom(
            //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultaAuditoriaScreen(),
                ),
              );
            },
            icon: Icon(Icons.assignment,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Auditorias realizadas',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton.icon(
            shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // style: ElevatedButton.styleFrom(
            //   shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            // ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultaInventarioScreen(),
                ),
              );
            },
            icon: Icon(Icons.receipt_long,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Consultas de inventario',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      )
    ]);
  }
}

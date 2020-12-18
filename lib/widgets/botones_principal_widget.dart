import 'package:flutter/material.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/auditoria_screen.dart';
import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesPrincipalWidget extends StatelessWidget {
  Product unProducto;
  Repository unRepositorio;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        buttonColor: Style.Colors.mainColor,
        height: MediaQuery.of(context).size.height * 0.1,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuditoriaScreen(),
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
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     //builder: (context) => ControlInventarioScreen(),
              //     builder: (context) => ProductScreen(),
              //   ),
              // );
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
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
            ),
            onPressed: () {
              unRepositorio.postNuevaAuditoria(context);
            },
            icon: Icon(Icons.assignment,
                size: 40, color: Style.Colors.secondColor),
            label: Text(
              'Consulta de auditorias',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      )
    ]);
  }
}

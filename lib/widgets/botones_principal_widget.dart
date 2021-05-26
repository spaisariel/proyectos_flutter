import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/auditoria_screen.dart';
//import 'package:prueba3_git/screens/consulta_auditoria_screen.dart';
import 'package:prueba3_git/screens/consulta_inventario_screen.dart';
import 'package:prueba3_git/screens/control_inventario_screen.dart';
import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesPrincipalWidget extends StatelessWidget {
  String idSucursal;
  String idDeposito;
  List<Reason> listaRazones;
  BotonesPrincipalWidget(this.idSucursal, this.idDeposito, this.listaRazones);
  Product unProducto;
  Repository unRepositorio;
  List<Item> listaItems = [];

  @override
  Widget build(BuildContext context) {
    List<Product> listaProductos = [];
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Style.Colors.mainColor),
                  shape: MaterialStateProperty.all(
                      Style.Shapes.botonGrandeRoundedRectangleBorder())),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuditoriaScreen(listaProductos,
                        listaRazones, listaItems, idSucursal, idDeposito),
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
      ),
      SizedBox(height: 20),
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Style.Colors.mainColor),
                  shape: MaterialStateProperty.all(
                      Style.Shapes.botonGrandeRoundedRectangleBorder())),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ControlInventarioScreen(
                        listaProductos, idSucursal, idDeposito, listaItems),
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
      ),
      SizedBox(height: 20),
      // ButtonTheme(
      //   child: ConstrainedBox(
      //     constraints: BoxConstraints.tightFor(
      //         width: MediaQuery.of(context).size.width * 0.8,
      //         height: MediaQuery.of(context).size.height * 0.1),
      //     child: ElevatedButton.icon(
      //         style: ButtonStyle(
      //             backgroundColor:
      //                 MaterialStateProperty.all<Color>(Style.Colors.mainColor),
      //             shape: MaterialStateProperty.all(
      //                 Style.Shapes.botonGrandeRoundedRectangleBorder())),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ConsultaAuditoriaScreen(),
      //             ),
      //           );
      //         },
      //         icon: Icon(Icons.assignment,
      //             size: 40, color: Style.Colors.secondColor),
      //         label: Text(
      //           'Auditorias realizadas',
      //           style: TextStyle(color: Colors.white, fontSize: 20),
      //         )),
      //   ),
      // ),
      // SizedBox(height: 20),
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Style.Colors.mainColor),
                  shape: MaterialStateProperty.all(
                      Style.Shapes.botonGrandeRoundedRectangleBorder())),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultaInventarioScreen(),
                  ),
                );
              },
              icon: Icon(Icons.assignment,
                  size: 40, color: Style.Colors.secondColor),
              label: Text(
                'Operaciones realizadas',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
      )
    ]);
  }
}

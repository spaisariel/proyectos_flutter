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
    double fuenteBotonGrande = 0.06;

    List<Product> listaProductos = [];
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton(
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
            child: FittedBox(
              child: Row(
                children: [
                  Icon(Icons.shopping_cart,
                      size: 25, color: Style.Colors.secondColor),
                  Text(
                    'Auditoría de góndola',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonGrande),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton(
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
            child: FittedBox(
              child: Row(
                children: [
                  Icon(Icons.assignment_turned_in,
                      size: 25, color: Style.Colors.secondColor),
                  Text(
                    'Control de inventario',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonGrande),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      ButtonTheme(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.1),
          child: ElevatedButton(
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
            child: FittedBox(
              child: Row(
                children: [
                  Icon(Icons.assignment,
                      size: 25, color: Style.Colors.secondColor),
                  Text(
                    'Operaciones realizadas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            fuenteBotonGrande),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

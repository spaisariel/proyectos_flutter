// import 'package:flutter/material.dart';
// import 'package:prueba3_git/models/todo.dart';
// import 'package:prueba3_git/style/theme.dart' as Style;

// class FiltroBusquedaWidget extends StatefulWidget {
//   final List<Todo> lista;
//   FiltroBusquedaWidget(this.lista);

//   @override
//   _FiltroBusquedaWidgetState createState() =>
//       _FiltroBusquedaWidgetState(this.lista);
// }

// class _FiltroBusquedaWidgetState extends State<FiltroBusquedaWidget> {
//   final List<Todo> lista;
//   _FiltroBusquedaWidgetState(this.lista);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 30,
//         color: Style.Colors.secondColor,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FlatButton(
//               color: Style.Colors.secondColor,
//               child: Text('Filtros'),
//               onPressed: () {
//                 _showMaterialDialog(context, lista);
//               },
//             )
//           ],
//         ));
//   }
// }

// _showMaterialDialog(context, List<Todo> lista) {
//   List<bool> listadefiltros;
//   showDialog(
//       context: context,
//       builder: (_) => new AlertDialog(
//             title: new Text("Filtrar busqueda"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [Text('Filtro 1'), Text('Filtro 2'), Text('Filtro 3')],
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Aceptar'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           ));
// }

import 'package:flutter/material.dart';
import 'package:prueba3_git/models/product.dart';
//import 'package:prueba3_git/models/todo.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class FiltroBusquedaWidget extends StatefulWidget {
  final List<Product> lista;
  FiltroBusquedaWidget(this.lista);

  @override
  _FiltroBusquedaWidgetState createState() =>
      _FiltroBusquedaWidgetState(this.lista);
}

class _FiltroBusquedaWidgetState extends State<FiltroBusquedaWidget> {
  final List<Product> lista;
  _FiltroBusquedaWidgetState(this.lista);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        color: Style.Colors.secondColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              color: Style.Colors.secondColor,
              child: Text('Filtros'),
              onPressed: () {
                _showMaterialDialog(context, lista);
              },
            )
          ],
        ));
  }
}

_showMaterialDialog(context, List<Product> lista) {
  //List<bool> listadefiltros;
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Filtrar busqueda"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Filtro 1'), Text('Filtro 2'), Text('Filtro 3')],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

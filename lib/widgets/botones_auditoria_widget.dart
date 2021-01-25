import 'package:flutter/material.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/user.dart';
import '../style/theme.dart' as Style;

// ignore: must_be_immutable
class BotonesAuditoriaWidget extends StatelessWidget {
  User unUsuario;
  @override
  Widget build(BuildContext context) {
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

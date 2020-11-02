import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/menu_screen.dart';
import '../style/theme.dart' as Style;

class BotonesAuditoriaWidget extends StatelessWidget {
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
              onPressed: () {
                //Navigator.of(context).pop();
                _showMaterialDialogCancelar(context);
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
              onPressed: () {
                //Navigator.of(context).pop();
                _showMaterialDialogAceptar(context);
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

  _showMaterialDialogAceptar(context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title:
                  new Text("Se guardo correctamente la auditoria de gondola"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuScreen()));
                  },
                )
              ],
            ));
  }

  _showMaterialDialogCancelar(context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "¿Seguro desea cancelar la auditoria? Perderá los datos no guardados"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Si'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuScreen()));
                  },
                ),
              ],
            ));
  }
}

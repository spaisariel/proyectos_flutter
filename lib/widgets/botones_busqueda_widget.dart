import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/busquedamanual_screen.dart';
import '../style/theme.dart' as Style;

class BotonesBusquedaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonTheme(
          buttonColor: Style.Colors.mainColor,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton.icon(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusquedaManualScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Style.Colors.secondColor,
                size: 40,
              ),
              label: Column(
                children: [
                  Text('Busqueda',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('Manual',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        ),
        SizedBox(width: 20),
        ButtonTheme(
          buttonColor: Style.Colors.mainColor,
          height: MediaQuery.of(context).size.height * 0.1,
          minWidth: MediaQuery.of(context).size.width * 0.4,
          child: RaisedButton.icon(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {},
              icon: Icon(
                Icons.camera,
                color: Style.Colors.secondColor,
                size: 40,
              ),
              label: Column(
                children: [
                  Text('Busqueda',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('QR',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        )
      ],
    );
  }
}

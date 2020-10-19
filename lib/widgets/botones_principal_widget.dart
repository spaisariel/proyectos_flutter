import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/screens/auditoria_screen.dart';
import '../style/theme.dart' as Style;

class BotonesPrincipalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Style.Colors.mainColor,
                  width: 2,
                )),
            color: Style.Colors.secondColor,
            textColor: Style.Colors.titleColor,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuditoriaScreen(),
                ),
              );
            },
            child: Row(children: <Widget>[
              Icon(EvaIcons.archiveOutline, size: 80),
              Text(
                '''AUDITORÁ DE GONDOLA'''.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ])),
        SizedBox(height: 25),
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Style.Colors.mainColor,
                  width: 2,
                )),
            onPressed: () {},
            color: Style.Colors.secondColor,
            textColor: Style.Colors.titleColor,
            child: Row(children: <Widget>[
              Icon(Icons.accessibility, size: 80),
              Text(
                '''CONTROL DE INVENTARIO'''.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ])),
        SizedBox(height: 25),
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Style.Colors.mainColor,
                  width: 2,
                )),
            onPressed: () {},
            color: Style.Colors.secondColor,
            textColor: Style.Colors.titleColor,
            child: Row(children: <Widget>[
              Icon(Icons.accessibility_new, size: 80),
              Text(
                '''CONSULTAS DE AUDITORIAS'''.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ])),
      ],
    );
  }
}

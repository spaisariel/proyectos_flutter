import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../style/theme.dart' as Style;

class BotonesBusquedaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
            minWidth: 150,
            height: 150,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Style.Colors.mainColor,
                  width: 2,
                )),
            color: Style.Colors.secondColor,
            textColor: Style.Colors.titleColor,
            padding: EdgeInsets.all(8.0),
            onPressed: () {},
            child: Column(children: <Widget>[
              Icon(EvaIcons.edit, size: 80),
              Text(
                '''Busqueda
  manual'''
                    .toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ])),
        SizedBox(width: 10),
        FlatButton(
            minWidth: 150,
            height: 150,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Style.Colors.mainColor,
                  width: 2,
                )),
            onPressed: () {},
            color: Style.Colors.secondColor,
            textColor: Style.Colors.titleColor,
            child: Column(children: <Widget>[
              Icon(Icons.scanner, size: 80),
              Text(
                '''Busqueda
       QR'''
                    .toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ])),
      ],
    );
  }
}

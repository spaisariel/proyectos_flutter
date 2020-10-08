import 'package:flutter/material.dart';
import 'package:prueba3_git/widgets/appbar_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/auditoria_datatable_widget.dart';
import 'package:prueba3_git/widgets/boxdecoration_widget.dart';

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBarWidget('Auditoria'),
      body: ListView(
        children: <Widget>[
          BoxDecorationWidget(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {},
                  child: Text('Buscar'),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Buscar'),
                )
              ],
            ),
          ),
          BoxDecorationWidget(AuditoriaTablaWidget()),
        ],
      ),
      //navigationbar_widget()
    );
  }
}

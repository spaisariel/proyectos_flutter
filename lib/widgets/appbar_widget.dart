import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Size preferredSize;

  AppBarWidget(this.title, {Key key})
      : preferredSize = Size.fromHeight(100.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        backgroundColor: Style.Colors.mainColor);
  }
}

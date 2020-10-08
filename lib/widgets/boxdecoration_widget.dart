import 'package:flutter/material.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class BoxDecorationWidget extends StatelessWidget {
  final Widget widget;
  const BoxDecorationWidget(this.widget, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(30.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(width: 3.0, color: Style.Colors.secondColor),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: widget);
  }
}

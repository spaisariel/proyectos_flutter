import 'package:flutter/material.dart';
import '../blocs/get_login_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();

  bool updateShouldNotify(_) => true;

  Provider({Key key, Widget child}) : super(key: key, child: child);

  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).bloc;
  }
}

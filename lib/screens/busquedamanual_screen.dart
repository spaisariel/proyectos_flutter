import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_todolist_bloc.dart';
import 'package:prueba3_git/models/todo.dart';
import 'package:prueba3_git/models/todo_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class BusquedaManualScreen extends StatefulWidget {
  BusquedaManualScreen({Key key}) : super(key: key);

  @override
  _BusquedaManualScreenState createState() => _BusquedaManualScreenState();
}

class _BusquedaManualScreenState extends State<BusquedaManualScreen> {
  List<Todo> lista;
  List<bool> filtrosSeleccionados;
  Todo filtroSeleccionado;

  @override
  void initState() {
    super.initState();
    todoListBloc..getTodoLista();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodoResponse>(
      stream: todoListBloc.subject.stream,
      builder: (context, AsyncSnapshot<TodoResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(TodoResponse data) {
    lista = data.todos;

    if (lista.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: Style.Colors.blanco,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Busqueda manual'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FiltroWidget(lista),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ingrese nombre o codigo',
                      ),
                    )),
                IconButton(icon: Icon(Icons.search), onPressed: null)
              ],
            ),
            SizedBox(height: 20),
            ButtonTheme(
                buttonColor: Style.Colors.mainColor,
                child: RaisedButton(
                    child: Text(
                      'Buscar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {}))
          ],
        ),
      );
  }
}

class FiltroWidget extends StatefulWidget {
  final List<Todo> lista;
  FiltroWidget(this.lista);

  @override
  _FiltroWidgetState createState() => _FiltroWidgetState(this.lista);
}

class _FiltroWidgetState extends State<FiltroWidget> {
  final List<Todo> lista;
  _FiltroWidgetState(this.lista);

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

_showMaterialDialog(context, List<Todo> lista) {
  List<bool> listadefiltros;
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Filtrar busqueda"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
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

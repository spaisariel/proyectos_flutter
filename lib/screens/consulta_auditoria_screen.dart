import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_todolist_bloc.dart';
import 'package:prueba3_git/models/todo.dart';
import 'package:prueba3_git/models/todo_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/auditoria_datatable_widget.dart';
import 'package:prueba3_git/widgets/filtro_busqueda_widget.dart';

class ConsultaAuditoriaScreen extends StatefulWidget {
  ConsultaAuditoriaScreen({Key key}) : super(key: key);

  @override
  _ConsultaAuditoriaScreenState createState() =>
      _ConsultaAuditoriaScreenState();
}

class _ConsultaAuditoriaScreenState extends State<ConsultaAuditoriaScreen> {
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
          title: Text('Consulta de auditorias'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FiltroBusquedaWidget(lista),
              AuditoriaTablaWidget(),
            ],
          ),
        ),
      );
  }
}

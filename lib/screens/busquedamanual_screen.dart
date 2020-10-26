import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_photolist_bloc.dart';
import 'package:prueba3_git/blocs/get_todolist_bloc.dart';
import 'package:prueba3_git/models/photo.dart';
import 'package:prueba3_git/models/photo_response.dart';
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

  @override
  void initState() {
    super.initState();
    todoListBloc..getTodoLista();
  }

  void _value1Changed(bool value, int index) {
    setState(() => lista[index].completed = value);
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
    //List<Photo> albums = data.photos;
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
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Busqueda manual'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Style.Colors.secondColor,
                  boxShadow: [
                    BoxShadow(color: Style.Colors.mainColor, spreadRadius: 3),
                  ],
                ),

                //color: Style.Colors.mainColor,
                child: Column(
                  children: [
                    ExpansionTile(
                      //backgroundColor: Style.Colors.secondColor,
                      //tilePadding: EdgeInsets.all(20),
                      //childrenPadding: EdgeInsets.symmetric(vertical: 20),

                      title: Text(
                        lista[index].title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              lista[index].title,
                              overflow: TextOverflow.ellipsis,
                              textWidthBasis: TextWidthBasis.parent,
                            ),
                            Checkbox(
                              value: lista[index].completed,
                              onChanged: (value) =>
                                  _value1Changed(value, index),
                            )
                          ],
                        )
                      ],
                    ),
                    // SizedBox(height: 20)
                  ],
                ),
              );
            }),
      );
  }
}

class FiltroWidget extends StatefulWidget {
  final List<Photo> albums;
  FiltroWidget(this.albums);

  @override
  _FiltroWidgetState createState() => _FiltroWidgetState(this.albums);
}

class _FiltroWidgetState extends State<FiltroWidget> {
  final List<Photo> albums;
  _FiltroWidgetState(this.albums);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        color: Style.Colors.secondColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              child: Text('Filtro'),
              onPressed: () {},
            )
          ],
        ));
  }
}

/*
  ListView.builder(
          itemCount: albums.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              title: Text(albums[index].id.toString()),
              children: [Text(albums[index].title)],
            );
          },
        ),
        */

import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_todolist_bloc.dart';
import 'package:prueba3_git/models/todo.dart';
import 'package:prueba3_git/models/todo_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/auditoria_datatable_widget.dart';
import 'package:prueba3_git/widgets/filtro_busqueda_widget.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
          title: Text('Perfil de usuario'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [Expanded(child: Icon(Icons.person],)
            ],
          ),
        ),
      );
  }
}

/*
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
        Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                  icon: Icon(Icons.filter_1),
                  onPressed: () {
                    // Do something
                  }),
              expandedHeight: 220.0,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 50,
              backgroundColor: Colors.pink,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    fit: BoxFit.cover,
                  )),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(_buildList(50))),
            ),
          ],
        ),
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    listItems.add(
      Text(
        'mailgenerico@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(
      Text(
        'fsg@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(
      Text(
        'jhgjnfmhfhmnf@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(RaisedButton(onPressed: null));

    return listItems;
  }
}
*/

import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_photolist_bloc.dart';
//import 'package:prueba3_git/blocs/get_photolist_bloc.dart';
import 'package:prueba3_git/models/photo.dart';
import 'package:prueba3_git/models/photo_response.dart';
//import 'package:prueba3_git/models/photo_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Photo> lista;

  @override
  void initState() {
    super.initState();
    photoListBloc..getPhotoLista();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PhotoResponse>(
      stream: photoListBloc.subject.stream,
      builder: (context, AsyncSnapshot<PhotoResponse> snapshot) {
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

  Widget _buildHomeWidget(PhotoResponse data) {
    //List<Photo> albums = data.photos;
    lista = data.photos;
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
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Style.Colors.secondColor,
          appBar: AppBar(
            backgroundColor: Style.Colors.mainColor,
            title: Text('Producto'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(child: Image.network(lista[0].thumbnailUrl)),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(25),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Ink(
                        child: Column(
                          children: [
                            DatosItem(lista[index]),

                            SizedBox(
                              height: 20,
                            )
                            // SizedBox(height: 20)
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                      color: Style.Colors.cancelColor,
                      shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                      onPressed: () {},
                      child: Text(
                        'Quitar de la lista',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ),
            ],
          ),
        ),
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

class Datos {
  Datos(this.title, [this.children = const <Datos>[]]);

  final String title;
  final List<Datos> children;
}

class DatosItem extends StatelessWidget {
  const DatosItem(this.datos);

  final Photo datos;

  Widget _buildTiles(Photo item) {
    //if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Style.Colors.mainColor),
      //color: Style.Colors.mainColor,
      child: ExpansionTile(
        backgroundColor: Style.Colors.secondColor,
        key: PageStorageKey<Photo>(item),
        title: Text(item.title),
        children: [Text(item.id.toString()), Text(item.title)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(datos);
  }
}

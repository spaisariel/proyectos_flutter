//NO SE USA ESTA PANTALLA, UTILIZAR SOLO PARA SACAR REFERENCIAS
//DE COMO USAR LOS LISTVIEW CON TILES

import 'package:flutter/material.dart';
import '../style/theme.dart' as Style;

class DetalleAuditoriaScreen extends StatefulWidget {
  DetalleAuditoriaScreen({Key key}) : super(key: key);

  @override
  _DetalleAuditoriaScreenState createState() => _DetalleAuditoriaScreenState();
}

class _DetalleAuditoriaScreenState extends State<DetalleAuditoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
          title: Text('Producto'),
          centerTitle: true,
          backgroundColor: Style.Colors.mainColor,
        ),
        body: Column(children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(25),
            itemBuilder: (BuildContext context, int index) => Column(
              children: [
                DatosItem(data[index]),
                SizedBox(height: 20),
              ],
            ),
            itemCount: data.length,
          ),
          ButtonTheme(
            buttonColor: Style.Colors.mainColor,
            height: MediaQuery.of(context).size.height * 0.1,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                    color: Style.Colors.cancelColor,
                    shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
                    //style: ElevatedButton.styleFrom(
                    // primary: Style.Colors.cancelColor,
                    // shape:
                    //     Style.Shapes.botonGrandeRoundedRectangleBorder()),
                    onPressed: () {},
                    child: Text(
                      'Quitar de la lista',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            ),
          ),
        ]));
  }
}

class Datos {
  Datos(this.title, [this.children = const <Datos>[]]);

  final String title;
  final List<Datos> children;
}

final List<Datos> data = <Datos>[
  Datos(
    'Datos principales',
    <Datos>[
      Datos('Codigo: 305993'),
      Datos('Descripcion: Cinta 10 metros'),
      Datos('Unidad por bulto: 20 unidades'),
      Datos('Costo: \$30'),
      Datos('Existencia unidades: 52'),
    ],
  ),
  Datos(
    'Precios',
    <Datos>[
      Datos('Por presentacion: \$50'),
      Datos('Por lista: \$40'),
    ],
  ),
  Datos(
    'Existencias',
    <Datos>[
      Datos('Sub Heading 1'),
      Datos('Sub Heading 2'),
      Datos(
        'Armar table, estoy investigando',
        <Datos>[
          Datos('Row 1'),
          Datos('Row 2'),
          Datos('Row 3'),
          Datos('Row 4'),
        ],
      ),
    ],
  ),
  Datos(
    'Irregularidades',
    <Datos>[
      Datos('Actualizar precio'),
      Datos('Actualizar stock'),
    ],
  ),
];

class DatosItem extends StatelessWidget {
  const DatosItem(this.datos);

  final Datos datos;

  Widget _buildTiles(Datos root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Style.Colors.mainColor),
      //color: Style.Colors.mainColor,
      child: ExpansionTile(
        backgroundColor: Style.Colors.secondColor,
        key: PageStorageKey<Datos>(root),
        title: Text(root.title),
        children: root.children.map(_buildTiles).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(datos);
  }
}

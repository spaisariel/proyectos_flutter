import 'package:flutter/material.dart';
import '../style/theme.dart' as Style;

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(25),
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            DatosItem(data[index]),
            SizedBox(height: 20),
          ],
        ),
        itemCount: data.length,
      ),
    );
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

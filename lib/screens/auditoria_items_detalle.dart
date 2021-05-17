import 'package:flutter/material.dart';
//import 'package:group_listview_demo/traction_group_seprator.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/screens/product_screen.dart';

class GroupListViewDemo extends StatefulWidget {
  final List<Item> listaItems;

  GroupListViewDemo(this.listaItems);
  @override
  _GroupListViewDemoState createState() =>
      _GroupListViewDemoState(this.listaItems);
}

class _GroupListViewDemoState extends State<GroupListViewDemo> {
  List<Item> listaItems;
  List<Reason> listaRazones;
  List auditoria;
  List razones;

  _GroupListViewDemoState(this.listaItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de razones'),
        centerTitle: true,
      ),
      body: GroupedListView<dynamic, String>(
        elements: listaItems,
        groupBy: (element) => element.reasons[0].descripcion,
        order: GroupedListOrder.DESC,
        // useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    element.productId.toString(),
                    '',
                    '',
                    listaRazones,
                  ),
                ),
              ),
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    element.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'Observación: ' + element.reasons[0].observations,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          );
        },
      ),
    );
  }
}

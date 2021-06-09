import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/product_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class AuditoriaDetalleScreen extends StatefulWidget {
  final Auditoria unaAuditoria;
  final String tipo;
  AuditoriaDetalleScreen(this.unaAuditoria, this.tipo);
  @override
  _AuditoriaDetalleScreenState createState() =>
      _AuditoriaDetalleScreenState(this.unaAuditoria, this.tipo);
}

class _AuditoriaDetalleScreenState extends State<AuditoriaDetalleScreen> {
  final Auditoria unaAuditoria;
  final String tipo;
  _AuditoriaDetalleScreenState(this.unaAuditoria, this.tipo);
  List<Auditoria> listaAuditorias;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auditoria unaAuditoriaInfo = unaAuditoria;

    final GlobalKey<ExpansionTileCardState> cardPrincipal = new GlobalKey();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: FittedBox(
            child: Text(unaAuditoriaInfo.nameOperationType +
                ' N°: ' +
                unaAuditoriaInfo.operationType),
          ),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _showMaterialDialogEliminar(context, unaAuditoriaInfo);
                  },
                  child: Icon(Icons.delete),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              datosPrincipales(cardPrincipal, unaAuditoriaInfo),
              (unaAuditoriaInfo.nameOperationType == "Auditoria Gondola")
                  ? listaProductosGondola(unaAuditoriaInfo)
                  : listaProductosStock(unaAuditoriaInfo)
            ],
          ),
        ),
      ),
    );
  }

  Widget listaProductosGondola(Auditoria unaAuditoriaInfo) {
    List<Item> auditoriaItems = unaAuditoriaInfo.items;
    List<Reason> listaRazones = [];

    return Container(
        child: FittedBox(
      child: DataTable(
        columnSpacing: 10,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Nombre',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Cantidad',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Razones',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: auditoriaItems
            .map(
              (auditItem) => DataRow(
                cells: [
                  DataCell(
                    Container(
                      width: 200,
                      child: Text(auditItem.name ?? "No tiene"),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                            auditItem.productId, '', listaRazones),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 40,
                      child: Text(
                        auditItem.quantity.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(
                        auditItem.reasons[0].descripcion,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onTap: () =>
                        _showMaterialDialogReasons(context, auditItem.reasons),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    ));
  }

  Widget listaProductosStock(Auditoria unaAuditoriaInfo) {
    List<Item> auditoriaItems = unaAuditoriaInfo.items;
    List<Reason> listaRazones = [];

    return Container(
        child: FittedBox(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Nombre',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Cantidad',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: auditoriaItems
            .map((auditItem) => DataRow(cells: [
                  DataCell(
                    Container(
                      width: 200,
                      child: Text(auditItem.name ?? "No tiene"),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                            auditItem.productId, '', listaRazones),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(auditItem.quantity.toString()),
                  ),
                ]))
            .toList(),
      ),
    ));
  }
}

Widget datosPrincipales(cardPrincipal, Auditoria unaAuditoriaInfo) {
  return ExpansionTileCard(
    initiallyExpanded: true,
    baseColor: Style.Colors.blanco,
    expandedColor: Colors.grey,
    key: cardPrincipal,
    leading: CircleAvatar(child: Icon(Icons.description)),
    title: Text(
      "Datos de la operacion",
      style: TextStyle(color: Colors.black),
    ),
    children: <Widget>[
      Divider(
        thickness: 1.0,
        height: 1.0,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              Wrap(
                runSpacing: 20,
                spacing: 50,
                children: [
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Fecha: '),
                            TextSpan(
                                text: (unaAuditoriaInfo.date).substring(0, 10),
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ])),
                  RichText(
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: 'Tipo comprobante: '),
                        TextSpan(
                            text: unaAuditoriaInfo.abbreviationOperationType,
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: 'Numero comprobante: '),
                        TextSpan(
                            text: unaAuditoriaInfo.id.toString(),
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: 'Sucursal: '),
                        TextSpan(
                            text: unaAuditoriaInfo.branchOfficeName,
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: 'Deposito: '),
                        TextSpan(
                            text: unaAuditoriaInfo.depositName,
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  RichText(
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: 'Observacion: '),
                        TextSpan(
                            text: unaAuditoriaInfo.observations,
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

_showMaterialDialogReasons(context, List<Reason> auditItem) {
  showDialog(
    context: context,
    builder: (_) => new AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: new Text("Listado de razones"),
      content: FittedBox(
        child: DataTable(
          columnSpacing: 30.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Descripcion',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Observación',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: auditItem
              .map((rasones) => DataRow(cells: [
                    DataCell(
                      Text(rasones.id.toString()),
                    ),
                    DataCell(
                      Text(rasones.descripcion),
                    ),
                    DataCell(
                      Text(
                        rasones.observations ?? 'No tiene',
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Style.Colors.acceptColor2)),
          child: Text(
            'Aceptar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ),
  );
}

_showMaterialDialogEliminar(context, Auditoria auditoriaBorrar) {
  String nombreOperacion = auditoriaBorrar.nameOperationType;
  showDialog(
    context: context,
    builder: (_) => new AlertDialog(
      title: new Text(
          "¿Seguro desea eliminar la $nombreOperacion? Perderá todos los datos de la misma."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.cancelColor2)),
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 50,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Style.Colors.acceptColor2)),
                child: Text(
                  'Si',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Se eliminó correctamente'),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Repository().deleteAudit(auditoriaBorrar.id);
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
}

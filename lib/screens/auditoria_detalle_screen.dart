import 'package:flutter/material.dart';
//import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
//import 'package:prueba3_git/models/auditoriaInfo_response.dart';
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
    //auditoriaInfoBloc..getAuditoriaGondolaPorID(idValue);
  }

  @override
  Widget build(BuildContext context) {
    Auditoria unaAuditoriaInfo = unaAuditoria;
    unaAuditoriaInfo.depositName = "";

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Auditoria N°: ' + unaAuditoriaInfo.id.toString()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (tipo == "gondola")
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

    return Container(
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
        DataColumn(
          label: Text(
            'Razones',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: auditoriaItems
          .map((auditItem) => DataRow(cells: [
                DataCell(
                  Text(auditItem.name ?? "No tiene"),
                ),
                DataCell(
                  Text(auditItem.quantity.toString()),
                ),
                DataCell(Text(auditItem.reasons[0].descripcion),
                    onTap: () =>
                        _showMaterialDialogReasons(context, auditItem.reasons)),
              ]))
          .toList(),
    ));
  }

  Widget listaProductosStock(Auditoria unaAuditoriaInfo) {
    List<Item> auditoriaItems = unaAuditoriaInfo.items;

    return Container(
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
                  Text(auditItem.name ?? "No tiene/Arrgelar"),
                ),
                DataCell(
                  Text(auditItem.quantity.toString()),
                ),
              ]))
          .toList(),
    ));
  }
}

_showMaterialDialogReasons(context, List<Reason> auditItem) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            insetPadding: EdgeInsets.all(10),
            title: new Text("Listado de razones"),
            content: DataTable(
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
                            rasones.observations,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ));
}

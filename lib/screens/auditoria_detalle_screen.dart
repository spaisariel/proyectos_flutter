import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoriaInfo_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class AuditoriaDetalleScreen extends StatefulWidget {
  final String idValue;
  AuditoriaDetalleScreen(this.idValue);
  @override
  _AuditoriaDetalleScreenState createState() =>
      _AuditoriaDetalleScreenState(this.idValue);
}

class _AuditoriaDetalleScreenState extends State<AuditoriaDetalleScreen> {
  final String idValue;
  _AuditoriaDetalleScreenState(this.idValue);
  List<Auditoria> listaAuditorias;
  Auditoria unaAudutoria;

  @override
  void initState() {
    super.initState();
    auditoriaInfoBloc..getAuditoriaGondolaPorID(idValue);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuditoriaInfoResponse>(
      stream: auditoriaInfoBloc.subject.stream,
      builder: (context, AsyncSnapshot<AuditoriaInfoResponse> snapshot) {
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

  Widget _buildHomeWidget(AuditoriaInfoResponse data) {
    Auditoria unaAuditoriaInfo = data.auditoria;

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
              listaProductos(unaAuditoriaInfo),
            ],
          ),
        ),
      ),
    );
  }

  Widget listaProductos(Auditoria unaAuditoriaInfo) {
    List<Item> auditoriaItems = unaAuditoriaInfo.items;

    return Container(
        child: DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'ID',
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
                  Text(auditItem.id.toString()),
                ),
                DataCell(
                  Text(auditItem.quantity.toString()),
                ),
                DataCell(Text('Ver errores acá'),
                    onTap: () =>
                        _showMaterialDialogCancelar(context, auditItem.reasons)
                    //+ auditItem.reasons[0].id.toString()),
                    ),
              ]))
          .toList(),
    ));
  }
}

_showMaterialDialogCancelar(context, List<Reason> auditItem) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Listado de razones"),
            content: DataTable(
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
              ],
              rows: auditItem
                  .map((rasones) => DataRow(cells: [
                        DataCell(
                          Text(rasones.id.toString()),
                        ),
                        DataCell(
                          Text(rasones.descripcion),
                        ),
                      ]))
                  .toList(),
            ),
          ));
}

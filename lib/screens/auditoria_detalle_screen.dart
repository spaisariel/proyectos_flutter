import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
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
    auditoriaListBloc..getAuditoriaLista();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuditoriaResponse>(
      stream: auditoriaListBloc.subject.stream,
      builder: (context, AsyncSnapshot<AuditoriaResponse> snapshot) {
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

  Widget _buildHomeWidget(AuditoriaResponse data) {
    List<Auditoria> auditorias = data.auditorias;
    if (auditorias.length == 0) {
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
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Detalle de auditoria'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: tablaAuditoria(auditorias),
                  alignment: Alignment.center),
              SizedBox(height: 80),
              Container(
                child: tablaItemsAuditoria(auditorias),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
      );
  }

  Widget tablaAuditoria(List<Auditoria> auditorias) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      child: DataTable(
        columnSpacing: 10, horizontalMargin: 10.0,

        //columnSpacing: 1.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Sucursal',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Deposito',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Observaciones',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: auditorias
            //A modo de demostracion, mas adelante se tendrá un endpoint que
            //devuelva una sola auditoria segun el ID proporcionado
            .take(1)
            .map(
              (auditoria) => DataRow(
                selected: auditorias.contains(auditoria),
                cells: [
                  DataCell(
                    Text(auditoria.id.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(
                      auditoria.branchOfficeId.toString(),
                    ),
                  ),
                  DataCell(
                    Text(
                      auditoria.depositId.toString(),
                    ),
                  ),
                  DataCell(
                    Text(
                      auditoria.observations,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget tablaItemsAuditoria(List<Auditoria> auditorias) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      child: DataTable(
        columnSpacing: 10, horizontalMargin: 10.0,

        //columnSpacing: 1.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Observaciones',
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
        rows: auditorias
            //A modo de demostracion, mas adelante se tendrá un endpoint que
            //devuelva una sola auditoria segun el ID proporcionado
            .take(3)
            .map(
              (auditoria) => DataRow(
                selected: auditorias.contains(auditoria),
                cells: [
                  DataCell(
                    Text(auditoria.items[1].id.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(
                      auditoria.items[1].observations,
                    ),
                  ),
                  DataCell(
                    Text(
                      auditoria.items[1].quantity.toString(),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

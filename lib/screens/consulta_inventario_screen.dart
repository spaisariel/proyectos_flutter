import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/screens/auditoria_detalle_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class ConsultaInventarioScreen extends StatefulWidget {
  @override
  _ConsultaInventarioScreenState createState() =>
      _ConsultaInventarioScreenState();
}

class _ConsultaInventarioScreenState extends State<ConsultaInventarioScreen> {
  List<Auditoria> listaAuditorias;
  Auditoria unaAudutoria;

  @override
  void initState() {
    super.initState();
    //auditoriaStockListBloc..getAuditoriaStockLista();
    auditoriasListBloc..getAuditoriasLista();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuditoriaResponse>(
      stream: auditoriasListBloc.subject.stream,
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
    auditorias.sort((a, b) => b.date.compareTo(a.date));
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
                  "No se encuentran auditorias anteriores",
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
          title: FittedBox(
            child: Text('Operaciones realizadas'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: tablaAuditoria(auditorias),
                  alignment: Alignment.center),
              SizedBox(height: 80),
            ],
          ),
        ),
      );
  }

  Widget tablaAuditoria(List<Auditoria> auditorias) {
    return FittedBox(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortColumnIndex: 0,
            sortAscending: true,
            columnSpacing: 10,
            horizontalMargin: 10.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Fecha',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Comprobante',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Sucursal',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Deposito',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            rows: auditorias
                .map(
                  (auditoria) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          (auditoria.date).substring(0, 10),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuditoriaDetalleScreen(
                              auditoria,
                              "stock",
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(
                        auditoria.abbreviationOperationType +
                            ' ' +
                            auditoria.operationType,
                        textAlign: TextAlign.center,
                      )),
                      DataCell(
                        Text(
                          auditoria.branchOfficeName,
                        ),
                      ),
                      DataCell(
                        Text(
                          auditoria.depositName,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_auditoria_widget.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

class AuditoriaScreen extends StatefulWidget {
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState();
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
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
          title: Text('Auditoria'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              BotonesBusquedaWidget(),
              SizedBox(height: 30),
              //AuditoriaTablaWidget(),
              tablaAuditoria(auditorias),
              SizedBox(height: 80),
              Container(
                child: BotonesAuditoriaWidget(),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      );
  }

  Widget tablaAuditoria(List<Auditoria> auditorias) {
    print(auditorias);
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
              'NOMBRE',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: auditorias
            .map(
              (auditoria) => DataRow(
                selected: auditorias.contains(auditoria),
                cells: [
                  DataCell(
                    Text(auditoria.id.toString()),
                    onTap: () {
                      // write your code..
                      // MaterialPageRoute(
                      //   Esto deberia llevar al detalle de una auditoria
                      //   con informacion de la misma(Fecha, productos cargados
                      //   etc)
                      // );
                    },
                  ),
                  DataCell(
                    Text(
                      auditoria.branchOfficeId.toString(),
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

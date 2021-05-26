import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_chart_bloc.dart';
import 'package:prueba3_git/models/chart_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    perfilBloc.getPerfil();
  }

  List<int> listaPuntos = [];
  List<FlSpot> listaPuntos2 = [];
  List<String> nombreGraficos = [];
  int index = 0;
  int coso = 0;
  String dropDownValue;

  Widget build(BuildContext context) {
    return StreamBuilder<PerfilResponse>(
      stream: perfilBloc.subject.stream,
      builder: (context, AsyncSnapshot<PerfilResponse> snapshot) {
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

  Widget _buildHomeWidget(PerfilResponse data) {
    nombreGraficos = [];
    listaPuntos = [];

    data.datos.consultasDashboard.forEach((grafico) {
      nombreGraficos.add(grafico.descripcion);
    });

    dropDownValue = nombreGraficos[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Reporteria'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new DropdownButton<String>(
              value: dropDownValue,
              items: nombreGraficos.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            StreamBuilder(
              stream: chartBloc.subject.stream,
              initialData: chartBloc..getChart('1156'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                snapshot.data.graficos.datos[0].data.forEach((punto) {
                  listaPuntos.add(punto);
                });

                if (coso == 0) puntosPrueba();
                coso++;

                return Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: listaPuntos2,
                            isCurved: false,
                            barWidth: 3,
                            colors: [
                              Colors.orange,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<FlSpot> puntosPrueba() {
    listaPuntos.forEach((unPunto) {
      listaPuntos2.add(FlSpot(index.toDouble(), unPunto.toDouble()));
      index++;
    });
    return listaPuntos2;
  }
}

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
    chartBloc..getChart('1156');
  }

  List<int> listaPuntos = [];
  List<FlSpot> listaPuntos2 = [];
  int index = 0;
  int coso = 0;

  //SOLO PARA MUESTRA
  String dropdownValue = 'Ventas por dia';

  Widget build(BuildContext context) {
    return StreamBuilder<ChartResponse>(
      stream: chartBloc.subject.stream,
      builder: (context, AsyncSnapshot<ChartResponse> snapshot) {
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

  Widget _buildHomeWidget(ChartResponse data) {
    data.graficos.datos[0].data.forEach((punto) {
      listaPuntos.add(punto);
    });

    if (coso == 0) puntosPrueba();
    coso++;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Auditoria - ' + data.graficos.titulo),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new DropdownButton<String>(
              value: dropdownValue,
              items: <String>[
                'Ventas por dia',
                'Ventas por mes',
                'Ventas sucursal 1',
                'Ventas sucursal 2'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(height: 20),
            Container(
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
            ),
            Text(data.graficos.datos[0].name)
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

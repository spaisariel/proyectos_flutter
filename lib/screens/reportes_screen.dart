import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_chart_bloc.dart';
import 'package:prueba3_git/models/chart.dart';
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
  List<String> perfiles = [];
  int index = 0;
  int bandera = 0;
  String dropDownValue;
  String graficoSeleccionado;
  String perfilSeleccionado;
  int touchedIndex = -1;
  List<Color> coloresGraficos = [];

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
    perfiles = [];

    List<ConsultasPersonalizada> consultas = [];

    data.datos.consultasPersonalizadas.forEach((grafico) {
      ConsultasPersonalizada unaConsulta = new ConsultasPersonalizada();
      unaConsulta.codigoConsulta = grafico.codigoConsulta;
      unaConsulta.descripcion = grafico.descripcion;
      nombreGraficos.add(grafico.descripcion);
      perfiles.add(grafico.codigoConsulta);
      consultas.add(unaConsulta);
    });

    //dropDownValue = consultas[0].descripcion;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: FittedBox(
          child: Text('Reporteria'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new DropdownButton<String>(
              value: dropDownValue,
              onChanged: (newValue) {
                consultas.forEach((consulta) {
                  if (newValue == consulta.descripcion) {
                    graficoSeleccionado = consulta.codigoConsulta;
                  }
                });
                //graficoSeleccionado = newValue;
                setState(() {
                  dropDownValue = newValue;
                  listaColores();
                });
              },
              items: nombreGraficos.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            StreamBuilder(
              stream: chartBloc.subject.stream,
              initialData: chartBloc..getChart(graficoSeleccionado),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                ChartResponse response = snapshot.data;
                Chart unGrafico = response.graficos;
                List nombresAbajo = unGrafico.categorias;

                switch (unGrafico.tipoGrafico) {
                  case "line":
                    return graficoLinea();
                    break;
                  case "pie":
                    return graficoTorta(unGrafico);
                    break;
                  case "column":
                    if (snapshot.data.graficos.datos[0].data != null)
                      snapshot.data.graficos.datos[0].data.forEach((punto) {
                        listaPuntos.add(punto);
                      });

                    puntosCartesianos();
                    return graficoBarra(nombresAbajo, unGrafico.titulo);
                    break;
                  default:
                    {
                      return graficoBarra(nombresAbajo, unGrafico.titulo);
                    }
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<FlSpot> puntosCartesianos() {
    listaPuntos.forEach((unPunto) {
      listaPuntos2.add(FlSpot(index.toDouble(), unPunto.toDouble()));
      index++;
    });
    index = 0;
    listaPuntos = [];
    return listaPuntos2;
  }

  Widget graficoLinea() {
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
  }

  Widget graficoTorta(Chart unGrafico) {
    Chart unGraficoTorta = unGrafico;
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                setState(() {
                  final desiredTouch =
                      pieTouchResponse.touchInput is! PointerExitEvent &&
                          pieTouchResponse.touchInput is! PointerUpEvent;
                  if (desiredTouch && pieTouchResponse.touchedSection != null) {
                    touchedIndex =
                        pieTouchResponse.touchedSection.touchedSectionIndex;
                  } else {
                    touchedIndex = -1;
                  }
                });
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 5,
              startDegreeOffset: 180,
              sections: showingSections(unGraficoTorta)),
        ),
      ),
    );
  }

  Widget graficoBarra(nombresAbajo, titulo) {
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
              titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return nombresAbajo[value.toInt()];
                      }))),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Chart unGraficoTorta) {
    int secciones = unGraficoTorta.datos[0].data2.length;
    int x = -1;
    return List.generate(secciones, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 12.0;
      final radius = isTouched ? 70.0 : 50.0;
      x++;
      Data2 info = unGraficoTorta.datos[0].data2[x];

      return PieChartSectionData(
        color: coloresGraficos[x],
        value: (info.y.toDouble() == 0) ? 1 : info.y.toDouble(),
        title: info.name,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }

  //Para colores del grafico, mas adelante se quita de aquí
  Color color1 = Color(0xFF357ebd);
  Color color2 = Color(0xFFFF0000);
  Color color3 = Color(0xFF4CAF50);
  Color color4 = Color(0xFF880E4F);
  Color color5 = Color(0xFFF4511E);
  Color color6 = Color(0xFFFFC107);
  Color color7 = Color(0xFFCDDC39);
  Color color8 = Color(0xFF009688);
  Color color9 = Color(0xFF03A9F4);
  Color color10 = Color(0xFF00ACC1);
  Color color11 = Color(0xFFFFEB3B);
  Color color12 = Color(0xFF9C27B0);
  Color color13 = Color(0xFF607D8B);
  Color color14 = Color(0xFF4CAF50);
  Color color15 = Color(0xFF673AB7);
  Color color16 = Color(0xFF3F51B5);
  Color color17 = Color(0xFF795548);
  Color color18 = Color(0xFF9E9E9E);
  Color color19 = Color(0xFF880E4F);
  Color color20 = Color(0xFFF8BBD0);
  Color color21 = Color(0xFFE65100);
  Color color22 = Color(0xFF827717);
  Color color23 = Color(0xFF64DD17);
  Color color24 = Color(0xFF1B5E20);
  Color color25 = Color(0xFF004D40);
  Color color26 = Color(0xFF33691E);
  Color color27 = Color(0xFF006064);
  Color color28 = Color(0xFFAA00FF);
  Color color29 = Color(0xFF4A148C);
  Color color30 = Color(0xFF01579B);
  Color color31 = Color(0xFF263238);
  Color color32 = Color(0xFF311B92);
  Color color33 = Color(0xFF3E2723);
  Color color34 = Color(0xFF212121);

  void listaColores() {
    coloresGraficos.add(color1);
    coloresGraficos.add(color2);
    coloresGraficos.add(color3);
    coloresGraficos.add(color4);
    coloresGraficos.add(color5);
    coloresGraficos.add(color6);
    coloresGraficos.add(color7);
    coloresGraficos.add(color8);
    coloresGraficos.add(color9);
    coloresGraficos.add(color10);
    coloresGraficos.add(color11);
    coloresGraficos.add(color12);
    coloresGraficos.add(color13);
    coloresGraficos.add(color14);
    coloresGraficos.add(color15);
    coloresGraficos.add(color16);
    coloresGraficos.add(color17);
    coloresGraficos.add(color18);
    coloresGraficos.add(color19);
    coloresGraficos.add(color20);
    coloresGraficos.add(color21);
    coloresGraficos.add(color22);
    coloresGraficos.add(color23);
    coloresGraficos.add(color24);
    coloresGraficos.add(color25);
    coloresGraficos.add(color26);
    coloresGraficos.add(color27);
    coloresGraficos.add(color28);
    coloresGraficos.add(color29);
    coloresGraficos.add(color30);
    coloresGraficos.add(color31);
    coloresGraficos.add(color32);
    coloresGraficos.add(color33);
    coloresGraficos.add(color34);
  }
}

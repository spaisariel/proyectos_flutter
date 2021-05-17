import 'package:prueba3_git/models/chart.dart';

class ChartResponse {
  final Chart graficos;
  final String error;

  ChartResponse(this.graficos, this.error);

  ChartResponse.fromJson(Map<String, dynamic> json)
      : graficos = (json["results"]).map((i) => new Chart.fromJson(i)),
        error = "";

  ChartResponse.withError(String errorValue)
      : graficos = Chart(),
        error = errorValue;
}

class PerfilResponse {
  final Perfil datos;
  final String error;

  PerfilResponse(this.datos, this.error);

  PerfilResponse.fromJson(Map<String, dynamic> json)
      : datos = (json["results"]).map((i) => new Perfil.fromJson(i)),
        error = "";

  PerfilResponse.withError(String errorValue)
      : datos = Perfil(),
        error = errorValue;
}

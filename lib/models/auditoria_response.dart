import 'package:prueba3_git/models/auditoria.dart';

class AuditoriaResponse {
  final List<Auditoria> auditorias;
  final String error;

  AuditoriaResponse(this.auditorias, this.error);

  AuditoriaResponse.fromJson(Map<String, dynamic> json)
      : auditorias = (json["results"] as List)
            .map((i) => new Auditoria.fromJson(i))
            .toList(),
        error = "";

  AuditoriaResponse.withError(String errorValue)
      : auditorias = [],
        error = errorValue;
}

class ReasonResponse {
  final List<Reason> razones;
  final String error;

  ReasonResponse(this.razones, this.error);

  ReasonResponse.fromJson(Map<String, dynamic> json)
      : razones = (json["results"] as List)
            .map((i) => new Reason.fromJson(i))
            .toList(),
        error = "";

  ReasonResponse.withError(String errorValue)
      : razones = [],
        error = errorValue;
}

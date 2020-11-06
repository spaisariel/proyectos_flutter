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
      : auditorias = List(),
        error = errorValue;
}

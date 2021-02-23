import 'package:prueba3_git/models/auditoria.dart';

class AuditoriaInfoResponse {
  final Auditoria auditoria;
  final String error;

  AuditoriaInfoResponse(this.auditoria, this.error);

  AuditoriaInfoResponse.fromJson(Map<String, dynamic> json)
      : auditoria = (json["results"]).map((i) => new Auditoria.fromJson(i)),
        error = "";

  AuditoriaInfoResponse.withError(String errorValue)
      : auditoria = Auditoria(),
        error = errorValue;
}

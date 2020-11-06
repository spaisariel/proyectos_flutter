import 'dart:convert';

List<Auditoria> auditoriaFromJson(String str) =>
    List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

String auditoriaToJson(List<Auditoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//En un futuro el modelo de auditoria deberia de tener la clase de productos tambien.
//Esta se realizo con fines demostrativos

class Auditoria {
  Auditoria({
    this.idCodigo,
    this.nombre,
  });

  int idCodigo;
  String nombre;

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        idCodigo: json["idCodigo"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idCodigo": idCodigo,
        "nombre": nombre,
      };
}

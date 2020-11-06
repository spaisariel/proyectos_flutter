import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.nombre,
    this.apellido,
    this.mail,
    this.telefono,
    this.direccion,
    this.cuit,
  });

  int id;
  String nombre;
  String apellido;
  String mail;
  String telefono;
  String direccion;
  String cuit;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        mail: json["mail"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        cuit: json["cuit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "mail": mail,
        "telefono": telefono,
        "direccion": direccion,
        "cuit": cuit,
      };
}

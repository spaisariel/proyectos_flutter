// import 'dart:convert';

// List<Auditoria> auditoriaFromJson(String str) =>
//     List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

// String auditoriaToJson(List<Auditoria> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// //En un futuro el modelo de auditoria deberia de tener la clase de productos tambien.
// //Esta se realizo con fines demostrativos

// class Auditoria {
//   Auditoria({
//     this.idCodigo,
//     this.nombre,
//   });

//   int idCodigo;
//   String nombre;

//   factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
//         idCodigo: json["idCodigo"],
//         nombre: json["nombre"],
//       );

//   Map<String, dynamic> toJson() => {
//         "idCodigo": idCodigo,
//         "nombre": nombre,
//       };
// }

import 'dart:convert';

List<Auditoria> auditoriaFromJson(String str) =>
    List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

String auditoriaToJson(List<Auditoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Auditoria {
  Auditoria({
    this.id,
    this.branchOfficeId,
    this.depositId,
    this.observations,
    this.items,
  });

  int id;
  int branchOfficeId;
  int depositId;
  String observations;
  Items items;

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        id: json["Id"],
        branchOfficeId: json["BranchOfficeId"],
        depositId: json["DepositId"],
        observations: json["Observations"],
        items: Items.fromJson(json["Items"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BranchOfficeId": branchOfficeId,
        "DepositId": depositId,
        "Observations": observations,
        "Items": items.toJson(),
      };
}

class Items {
  Items({
    this.id,
    this.productId,
    this.observations,
    this.quantity,
    this.presentationId,
  });

  int id;
  String productId;
  String observations;
  int quantity;
  String presentationId;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["Id"],
        productId: json["ProductId"],
        observations: json["Observations"],
        quantity: json["Quantity"],
        presentationId: json["PresentationId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "Observations": observations,
        "Quantity": quantity,
        "PresentationId": presentationId,
      };
}

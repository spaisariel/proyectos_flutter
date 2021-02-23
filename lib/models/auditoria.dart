import 'dart:convert';

//Inicio - Para multiples auditorias
List<Auditoria> auditoriaFromJson(String str) =>
    List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

String auditoriaToJson(Auditoria data) => json.encode(data.toJson());
//Fin

//Inicio - Para una sola auditoria
Auditoria auditoriaInfoFromJson(String str) =>
    Auditoria.fromJson(json.decode(str));

String auditoriaInfoToJson(Auditoria data) => json.encode(data.toJson());
//Fin

class Auditoria {
  Auditoria({
    this.id,
    this.branchOfficeId,
    this.depositId,
    this.observations,
    this.items,
  });

  int id;
  String branchOfficeId;
  String depositId;
  String observations;
  List<Item> items = new List<Item>();

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        id: json["Id"],
        branchOfficeId: json["BranchOfficeId"],
        depositId: json["DepositId"],
        observations: json["Observations"],
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BranchOfficeId": branchOfficeId,
        "DepositId": depositId,
        "Observations": observations,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.productId,
    this.quantity,
    this.presentationId,
    this.reasons,
  });

  int id;
  String productId;
  double quantity;
  String presentationId;
  List<Reason> reasons = new List<Reason>();

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["Id"],
        productId: json["ProductId"],
        quantity: json["Quantity"],
        presentationId: json["PresentationId"],
        reasons:
            List<Reason>.from(json["Reasons"].map((x) => Reason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "Quantity": quantity,
        "PresentationId": presentationId,
        "Reasons": List<dynamic>.from(reasons.map((x) => x.toJson())),
      };
}

class Reason {
  Reason({
    this.id,
    this.descripcion,
    this.observations,
  });

  int id;
  String descripcion;
  String observations;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["Id"],
        descripcion: json["Descripcion"],
        observations: json["Observations"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "Observations": observations,
      };
}

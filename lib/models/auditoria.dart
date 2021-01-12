import 'dart:convert';

List<Auditoria> auditoriaFromJson(String str) =>
    List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

// String auditoriaToJson(List<Auditoria> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String auditoriaToJson(Auditoria data) => json.encode(data.toJson());

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
    this.observations,
    this.quantity,
    this.presentationId,
    this.reasons,
  });

  int id;
  String productId;
  String observations;
  int quantity;
  String presentationId;
  List<Reason> reasons = new List<Reason>();

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["Id"],
        productId: json["ProductId"],
        observations: json["Observations"],
        quantity: json["Quantity"],
        presentationId: json["PresentationId"],
        reasons:
            List<Reason>.from(json["Reasons"].map((x) => Reason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "Observations": observations,
        "Quantity": quantity,
        "PresentationId": presentationId,
        "Reasons": List<dynamic>.from(reasons.map((x) => x.toJson())),
      };
}

class Reason {
  Reason({
    this.id,
    this.descripcion,
  });

  int id;
  String descripcion;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["Id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
      };
}

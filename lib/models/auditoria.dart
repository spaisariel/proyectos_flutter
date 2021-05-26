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

//inicio - Traer razones
List<Reason> reasonFromJson(String str) =>
    List<Reason>.from(json.decode(str).map((x) => Reason.fromJson(x)));

String reasonToJson(Reason data) => json.encode(data.toJson());
//Fin

class Auditoria {
  Auditoria({
    this.id,
    this.operationType,
    this.abbreviationOperationType,
    this.nameOperationType,
    this.date,
    this.branchOfficeId,
    this.branchOfficeName,
    this.depositId,
    this.depositName,
    this.observations,
    this.items,
  });

  int id;
  String operationType;
  String abbreviationOperationType;
  String nameOperationType;
  String date;
  String branchOfficeId;
  String branchOfficeName;
  String depositId;
  String depositName;
  String observations;
  List<Item> items = [];

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        id: json["Id"],
        operationType: json["OperationType"],
        abbreviationOperationType: json["AbbreviationOperationType"],
        nameOperationType: json["NameOperationType"],
        date: json["Date"],
        branchOfficeId: json["BranchOfficeId"],
        branchOfficeName: json["BranchOfficeName"],
        depositId: json["DepositId"],
        depositName: json["DepositName"],
        observations: json["Observations"],
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OperationType": operationType,
        "AbbreviationOperationType": abbreviationOperationType,
        "NameOperationType": nameOperationType,
        "Date": date,
        "BranchOfficeId": branchOfficeId,
        "BranchOfficeName": branchOfficeName,
        "DepositId": depositId,
        "DepositName": depositName,
        "Observations": observations,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.productId,
    this.name,
    this.quantity,
    this.presentationId,
    this.reasons,
  });

  int id;
  String productId;
  String name;
  double quantity;
  String presentationId;
  List<Reason> reasons = [];

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["Id"],
        productId: json["ProductId"],
        name: json["Name"],
        quantity: json["Quantity"],
        presentationId: json["PresentationId"],
        reasons:
            List<Reason>.from(json["Reasons"].map((x) => Reason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "Name": name,
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

  String id;
  String descripcion;
  String observations;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        id: json["Id"],
        descripcion: json["Description"],
        observations: json["Observations"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Description": descripcion,
        "Observations": observations,
      };
}

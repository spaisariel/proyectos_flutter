import 'dart:convert';

BranchOffice branchOfficeFromJson(String str) =>
    BranchOffice.fromJson(json.decode(str));

String branchOfficeToJson(BranchOffice data) => json.encode(data.toJson());

class BranchOffice {
  BranchOffice({
    this.branchOfficeId,
    this.name,
    this.latitude,
    this.longitude,
    this.deposits,
  });

  String branchOfficeId;
  String name;
  dynamic latitude;
  dynamic longitude;
  List<Deposit> deposits;

  factory BranchOffice.fromJson(Map<String, dynamic> json) => BranchOffice(
        branchOfficeId: json["BranchOfficeId"],
        name: json["Name"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        deposits: List<Deposit>.from(
            json["Deposits"].map((x) => Deposit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BranchOfficeId": branchOfficeId,
        "Name": name,
        "Latitude": latitude,
        "Longitude": longitude,
        "Deposits": List<dynamic>.from(deposits.map((x) => x.toJson())),
      };
}

class Deposit {
  Deposit({
    this.depositId,
    this.name,
  });

  String depositId;
  String name;

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        depositId: json["DepositId"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "DepositId": depositId,
        "Name": name,
      };
}

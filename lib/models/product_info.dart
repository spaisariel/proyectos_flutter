import 'dart:convert';

List<ProductInfo> productInfoFromJson(String str) => List<ProductInfo>.from(
    json.decode(str).map((x) => ProductInfo.fromJson(x)));

String productInfoToJson(List<ProductInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductInfo {
  ProductInfo({
    this.id,
    this.internalCode,
    this.codigoProveedorHabitual,
    this.codigoProveedorAlternativo,
    this.codigoPresentacionVenta,
    this.nombre,
    this.descripcion,
    this.unidadPorBulto,
    this.costo,
    //this.existenciaUnidades,
    this.precioPorPresentacion,
    this.precioPorLista,
    this.stocks,
  });

  String id;
  String internalCode;
  String codigoProveedorHabitual;
  String codigoProveedorAlternativo;
  String codigoPresentacionVenta;
  String nombre;
  String descripcion;
  int unidadPorBulto;
  double costo;
  //int existenciaUnidades;
  double precioPorPresentacion;
  double precioPorLista;
  List<Stock> stocks;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["Id"],
        internalCode: json["InternalCode"],
        codigoProveedorHabitual: json["CodigoProveedorHabitual"],
        codigoProveedorAlternativo: json["CodigoProveedorAlternativo"],
        codigoPresentacionVenta: json["CodigoPresentacionVenta"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        unidadPorBulto: json["UnidadPorBulto"],
        costo: json["Costo"],
        //existenciaUnidades: json["ExistenciaUnidades"],
        precioPorPresentacion: json["precioPorPresentacion"],
        precioPorLista: json["precioPorLista"],
        stocks: List<Stock>.from(json["Stocks"].map((x) => Stock.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "InternalCode": internalCode,
        "CodigoProveedorHabitual": codigoProveedorHabitual,
        "CodigoProveedorAlternativo": codigoProveedorAlternativo,
        "CodigoPresentacionVenta": codigoPresentacionVenta,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "UnidadPorBulto": unidadPorBulto,
        "Costo": costo,
        //"ExistenciaUnidades": existenciaUnidades,
        "precioPorPresentacion": precioPorPresentacion,
        "precioPorLista": precioPorLista,
        "Stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
      };
}

class Stock {
  Stock({
    this.depositId,
    this.depositName,
    this.branchOfficeId,
    this.branchOfficeName,
    this.presentationId,
    this.presentationName,
    this.quantity,
  });

  String depositId;
  String depositName;
  String branchOfficeId;
  String branchOfficeName;
  String presentationId;
  String presentationName;
  double quantity;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        depositId: json["DepositId"],
        depositName: json["DepositName"],
        branchOfficeId: json["BranchOfficeId"],
        branchOfficeName: json["BranchOfficeName"],
        presentationId: json["PresentationId"],
        presentationName: json["PresentationName"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "DepositId": depositId,
        "DepositName": depositName,
        "BranchOfficeId": branchOfficeId,
        "BranchOfficeName": branchOfficeName,
        "PresentationId": presentationId,
        "PresentationName": presentationName,
        "Quantity": quantity,
      };
}

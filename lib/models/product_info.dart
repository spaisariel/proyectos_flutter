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
    this.precioPorPresentacion,
    this.precioPorLista,
    this.stocks,
    this.precios,
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
  double precioPorPresentacion;
  double precioPorLista;
  List<Stock> stocks;
  List<Price> precios;

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
        precioPorPresentacion: json["precioPorPresentacion"],
        precioPorLista: json["precioPorLista"],
        stocks: List<Stock>.from(json["Stocks"].map((x) => Stock.fromJson(x))),
        precios: List<Price>.from(json["Prices"].map((x) => Price.fromJson(x))),
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
        "precioPorPresentacion": precioPorPresentacion,
        "precioPorLista": precioPorLista,
        "Stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
        "Prices": List<dynamic>.from(precios.map((x) => x.toJson())),
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

class Price {
  Price({
    this.price,
    this.priceName,
    this.presentation,
    this.isSale,
  });

  double price;
  String priceName;
  String presentation;
  bool isSale;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: json["Price"].toDouble(),
        priceName: json["PriceName"],
        presentation: json["Presentation"],
        isSale: json["isSale"],
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "PriceName": priceName,
        "Presentation": presentation,
        "isSale": isSale,
      };
}

import 'dart:convert';

ProductInfo productInfoFromJson(String str) =>
    ProductInfo.fromJson(json.decode(str));

String productInfoToJson(ProductInfo data) => json.encode(data.toJson());

class ProductInfo {
  ProductInfo({
    this.id,
    this.internalCode,
    this.codigoProveedorHabitual,
    this.codigoProveedorAlternativo,
    this.codigoPresentacionVenta,
    this.descripcion,
    this.unidadPorBulto,
    this.costo,
    this.prices,
    this.existenciaUnidades,
    this.stocks,
  });

  String id;
  String internalCode;
  String codigoProveedorHabitual;
  String codigoProveedorAlternativo;
  String codigoPresentacionVenta;
  String descripcion;
  int unidadPorBulto;
  double costo;
  List<Price> prices;
  int existenciaUnidades;
  List<Stock> stocks;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["Id"],
        internalCode: json["InternalCode"],
        codigoProveedorHabitual: json["CodigoProveedorHabitual"],
        codigoProveedorAlternativo: json["CodigoProveedorAlternativo"],
        codigoPresentacionVenta: json["CodigoPresentacionVenta"],
        descripcion: json["Descripcion"],
        unidadPorBulto: json["UnidadPorBulto"],
        costo: json["Costo"].toDouble(),
        prices: List<Price>.from(json["Prices"].map((x) => Price.fromJson(x))),
        existenciaUnidades: json["ExistenciaUnidades"],
        stocks: List<Stock>.from(json["Stocks"].map((x) => Stock.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "InternalCode": internalCode,
        "CodigoProveedorHabitual": codigoProveedorHabitual,
        "CodigoProveedorAlternativo": codigoProveedorAlternativo,
        "CodigoPresentacionVenta": codigoPresentacionVenta,
        "Descripcion": descripcion,
        "UnidadPorBulto": unidadPorBulto,
        "Costo": costo,
        "Prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "ExistenciaUnidades": existenciaUnidades,
        "Stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
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

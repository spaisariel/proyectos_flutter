import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.idCodigo,
    this.descripcion,
    this.unidadPorBulto,
    this.costo,
    this.existencia,
    this.precioPresentacion,
    this.precioLista,
    this.existenciaDepositos,
  });

  int idCodigo;
  String descripcion;
  String unidadPorBulto;
  String costo;
  String existencia;
  String precioPresentacion;
  String precioLista;
  ExistenciaDepositos existenciaDepositos;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idCodigo: json["idCodigo"],
        descripcion: json["descripcion"],
        unidadPorBulto: json["unidadPorBulto"],
        costo: json["costo"],
        existencia: json["existencia"],
        precioPresentacion: json["precioPresentacion"],
        precioLista: json["precioLista"],
        existenciaDepositos:
            ExistenciaDepositos.fromJson(json["existenciaDepositos"]),
      );

  Map<String, dynamic> toJson() => {
        "idCodigo": idCodigo,
        "descripcion": descripcion,
        "unidadPorBulto": unidadPorBulto,
        "costo": costo,
        "existencia": existencia,
        "precioPresentacion": precioPresentacion,
        "precioLista": precioLista,
        "existenciaDepositos": existenciaDepositos.toJson(),
      };
}

class ExistenciaDepositos {
  ExistenciaDepositos({
    this.deposito,
    this.sucursal,
    this.existenciaOtroLugar,
    this.presentacion,
  });

  String deposito;
  String sucursal;
  String existenciaOtroLugar;
  String presentacion;

  factory ExistenciaDepositos.fromJson(Map<String, dynamic> json) =>
      ExistenciaDepositos(
        deposito: json["deposito"],
        sucursal: json["sucursal"],
        existenciaOtroLugar: json["existenciaOtroLugar"],
        presentacion: json["presentacion"],
      );

  Map<String, dynamic> toJson() => {
        "deposito": deposito,
        "sucursal": sucursal,
        "existenciaOtroLugar": existenciaOtroLugar,
        "presentacion": presentacion,
      };
}

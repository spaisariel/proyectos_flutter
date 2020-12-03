// import 'dart:convert';

// List<ProductInfo> productInfoFromJson(String str) => List<ProductInfo>.from(
//     json.decode(str).map((x) => ProductInfo.fromJson(x)));

// String productInfoToJson(List<ProductInfo> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProductInfo {
//   ProductInfo({
//     this.id,
//     this.descripcion,
//     this.unidadPorBulto,
//     this.costo,
//     this.existenciaUnidades,
//   });

//   String id;
//   String descripcion;
//   int unidadPorBulto;
//   double costo;
//   int existenciaUnidades;

//   factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
//         id: json["Id"],
//         descripcion: json["Descripcion"],
//         unidadPorBulto: json["UnidadPorBulto"],
//         costo: json["Costo"],
//         existenciaUnidades: json["ExistenciaUnidades"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Descripcion": descripcion,
//         "UnidadPorBulto": unidadPorBulto,
//         "Costo": costo,
//         "ExistenciaUnidades": existenciaUnidades,
//       };
// }

import 'dart:convert';

List<ProductInfo> productInfoFromJson(String str) => List<ProductInfo>.from(
    json.decode(str).map((x) => ProductInfo.fromJson(x)));

String productInfoToJson(List<ProductInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductInfo {
  ProductInfo({
    this.id,
    this.descripcion,
    this.unidadPorBulto,
    this.costo,
    this.existenciaUnidades,
    this.precioPorPresentacion,
    this.precioPorLista,
    //this.existencias,
  });

  String id;
  String descripcion;
  int unidadPorBulto;
  double costo;
  int existenciaUnidades;
  double precioPorPresentacion;
  double precioPorLista;
  //Existencias existencias;

  //   String id;
//   String descripcion;
//   int unidadPorBulto;
//   double costo;
//   int existenciaUnidades;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["Id"],
        descripcion: json["Descripcion"],
        unidadPorBulto: json["UnidadPorBulto"],
        costo: json["Costo"],
        existenciaUnidades: json["ExistenciaUnidades"],
        precioPorPresentacion: json["precioPorPresentacion"],
        precioPorLista: json["precioPorLista"],
        //existencias: Existencias.fromJson(json["existencias"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "UnidadPorBulto": unidadPorBulto,
        "Costo": costo,
        "ExistenciaUnidades": existenciaUnidades,
        "precioPorPresentacion": precioPorPresentacion,
        "precioPorLista": precioPorLista,
        //"existencias": existencias.toJson(),
      };
}

// class Existencias {
//   Existencias({
//     this.deposito,
//     this.sucursal,
//     this.existencia,
//     this.presentacion,
//   });

//   String deposito;
//   String sucursal;
//   int existencia;
//   String presentacion;

//   factory Existencias.fromJson(Map<String, dynamic> json) => Existencias(
//         deposito: json["deposito"],
//         sucursal: json["sucursal"],
//         existencia: json["existencia"],
//         presentacion: json["presentacion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "deposito": deposito,
//         "sucursal": sucursal,
//         "existencia": existencia,
//         "presentacion": presentacion,
//       };
// }

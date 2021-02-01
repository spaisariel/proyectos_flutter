import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.internalCode,
    this.name,
    this.subcategorieId,
    this.subcategorieName,
    this.stock,
    this.price,
    this.priceToShow,
    this.image,
    this.description,
    this.info,
    this.score,
    this.priceId,
    this.includesIva,
    this.sales,
    this.unitsPerPackage,
    this.webDescription,
    this.order,
    this.containsVariations,
    this.store,
    this.observation,
  });

  String id;
  String internalCode;
  String name;
  String subcategorieId;
  String subcategorieName;
  double stock;
  double price;
  double priceToShow;
  String image;
  String description;
  String info;
  int score;
  String priceId;
  dynamic includesIva;
  int sales;
  double unitsPerPackage;
  String webDescription;
  int order;
  bool containsVariations;
  dynamic store;
  String observation;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["Id"],
        internalCode: json["InternalCode"],
        name: json["Name"],
        subcategorieId: json["SubcategorieId"],
        subcategorieName: json["SubcategorieName"],
        stock: json["Stock"],
        price: json["Price"],
        priceToShow: json["PriceToShow"],
        image: json["Image"],
        description: json["Description"],
        info: json["Info"],
        score: json["Score"],
        priceId: json["PriceId"],
        includesIva: json["IncludesIVA"],
        sales: json["Sales"],
        unitsPerPackage: json["UnitsPerPackage"],
        webDescription: json["WebDescription"],
        order: json["Order"],
        containsVariations: json["ContainsVariations"],
        store: json["Store"],
        observation: json["Observation"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "InternalCode": internalCode,
        "Name": name,
        "SubcategorieId": subcategorieId,
        "SubcategorieName": subcategorieName,
        "Stock": stock,
        "Price": price,
        "PriceToShow": priceToShow,
        "Image": image,
        "Description": description,
        "Info": info,
        "Score": score,
        "PriceId": priceId,
        "IncludesIVA": includesIva,
        "Sales": sales,
        "UnitsPerPackage": unitsPerPackage,
        "WebDescription": webDescription,
        "Order": order,
        "ContainsVariations": containsVariations,
        "Store": store,
        "Observation": observation,
      };
}

// class Price {
//   Price({
//     this.price,
//     this.priceName,
//     this.presentation,
//     this.isSale,
//   });

//   double price;
//   String priceName;
//   String presentation;
//   bool isSale;

//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         price: json["Price"].toDouble(),
//         priceName: json["PriceName"],
//         presentation: json["Presentation"],
//         isSale: json["isSale"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Price": price,
//         "PriceName": priceName,
//         "Presentation": presentation,
//         "isSale": isSale,
//       };
// }

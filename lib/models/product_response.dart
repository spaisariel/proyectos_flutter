import 'package:prueba3_git/models/product.dart';

class ProductResponse {
  final List<Product> products;
  final String error;

  ProductResponse(this.products, this.error);

  ProductResponse.fromJson(Map<String, dynamic> json)
      : products = (json["results"] as List)
            .map((i) => new Product.fromJson(i))
            .toList(),
        error = "";

  ProductResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}

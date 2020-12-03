import 'package:prueba3_git/models/product_info.dart';

class ProductInfoResponse {
  final List<ProductInfo> products;
  final String error;

  ProductInfoResponse(this.products, this.error);

  ProductInfoResponse.fromJson(Map<String, dynamic> json)
      : products = (json["results"] as List)
            .map((i) => new ProductInfo.fromJson(i))
            .toList(),
        error = "";

  ProductInfoResponse.withError(String errorValue)
      : products = List(),
        error = errorValue;
}

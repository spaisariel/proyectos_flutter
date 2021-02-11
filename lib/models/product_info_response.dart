import 'package:prueba3_git/models/product_info.dart';

class ProductInfoResponse {
  final ProductInfo product;
  final String error;

  ProductInfoResponse(this.product, this.error);

  ProductInfoResponse.fromJson(Map<String, dynamic> json)
      : product =
            (json["results"]).map((i) => new ProductInfo.fromJson(i)).toList(),
        error = "";

  ProductInfoResponse.withError(String errorValue)
      : product = ProductInfo(),
        error = errorValue;
}

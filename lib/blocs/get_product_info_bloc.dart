import 'package:prueba3_git/models/product_info_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductInfoBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductInfoResponse> _subject =
      BehaviorSubject<ProductInfoResponse>();

  getProduct(idValue) async {
    ProductInfoResponse response = await _repository.getProduct(idValue);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductInfoResponse> get subject => _subject;
}

final productInfoBloc = ProductInfoBloc();

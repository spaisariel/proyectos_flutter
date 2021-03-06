import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  String hint;
  String begin;
  String end;

  getProductLista(String hint, begin, end) async {
    ProductResponse response =
        await _repository.getProductList(hint, begin, end);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productListBloc = ProductListBloc();

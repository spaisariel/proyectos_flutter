import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  String hint;

  getProductLista(String hint) async {
    ProductResponse response = await _repository.getProductList(hint);
    _subject.sink.add(response);
  }

  getProductListaFake() async {
    ProductResponse response = await _repository.getProductosFake();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productListBloc = ProductListBloc();

import 'package:prueba3_git/models/photo_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListaBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<PhotoResponse> _subject =
      BehaviorSubject<PhotoResponse>();

  getPhotoLista() async {
    PhotoResponse response = await _repository.getPhotoLista();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PhotoResponse> get subject => _subject;
}

final albumListaBloc = AlbumListaBloc();

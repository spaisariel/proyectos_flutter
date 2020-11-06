import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuditoriaListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AuditoriaResponse> _subject =
      BehaviorSubject<AuditoriaResponse>();

  getAuditoriaLista() async {
    AuditoriaResponse response = await _repository.getAuditoriaList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AuditoriaResponse> get subject => _subject;
}

final auditoriaListBloc = AuditoriaListBloc();

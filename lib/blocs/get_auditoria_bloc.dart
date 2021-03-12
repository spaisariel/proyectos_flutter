import 'package:prueba3_git/models/auditoriaInfo_response.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuditoriaListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AuditoriaResponse> _subject =
      BehaviorSubject<AuditoriaResponse>();

  getAuditoriaLista() async {
    AuditoriaResponse response = await _repository.getAuditoriaRackList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AuditoriaResponse> get subject => _subject;
}

final auditoriaListBloc = AuditoriaListBloc();

class AuditoriaInfoBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<AuditoriaInfoResponse> _subject =
      BehaviorSubject<AuditoriaInfoResponse>();

  getAuditoriaGondolaPorID(idValue) async {
    AuditoriaInfoResponse response =
        await _repository.getAuditRackByID(idValue);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AuditoriaInfoResponse> get subject => _subject;
}

final auditoriaInfoBloc = AuditoriaInfoBloc();

class RazonesBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ReasonResponse> _subject =
      BehaviorSubject<ReasonResponse>();

  getRazonesLista() async {
    ReasonResponse response = await _repository.getReasons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ReasonResponse> get subject => _subject;
}

final razonesListBloc = RazonesBloc();

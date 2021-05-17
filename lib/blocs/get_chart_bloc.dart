import 'package:prueba3_git/models/chart_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChartBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<ChartResponse> _subject =
      BehaviorSubject<ChartResponse>();

  String code;

  getChart(String code) async {
    ChartResponse response = await _repository.getChartsByCode(code);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ChartResponse> get subject => _subject;
}

final chartBloc = ChartBloc();

class PerfilBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<PerfilResponse> _subject =
      BehaviorSubject<PerfilResponse>();

  String code;

  getPerfil() async {
    PerfilResponse response = await _repository.getCharts();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PerfilResponse> get subject => _subject;
}

final perfilBloc = PerfilBloc();

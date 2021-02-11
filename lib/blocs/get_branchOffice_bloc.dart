import 'package:prueba3_git/models/branchOffice_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class BranchOfficeListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<BranchOfficeResponse> _subject =
      BehaviorSubject<BranchOfficeResponse>();

  String idValue;

  getBranchOfficeLista(idValue) async {
    BranchOfficeResponse response =
        await _repository.getBranchOfficeList(idValue);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<BranchOfficeResponse> get subject => _subject;
}

final branchOfficeListBloc = BranchOfficeListBloc();

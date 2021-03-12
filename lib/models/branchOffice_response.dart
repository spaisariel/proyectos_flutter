import 'package:prueba3_git/models/branchOffice.dart';

class BranchOfficeResponse {
  final BranchOffice sucursales;
  final String error;

  BranchOfficeResponse(this.sucursales, this.error);

  BranchOfficeResponse.fromJson(Map<String, dynamic> json)
      : sucursales = (json["results"]).map((i) => new BranchOffice.fromJson(i)),
        error = "";

  BranchOfficeResponse.withError(String errorValue)
      : sucursales = BranchOffice(),
        error = errorValue;
}

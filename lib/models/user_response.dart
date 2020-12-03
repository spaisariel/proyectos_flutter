// import 'package:prueba3_git/models/user.dart';

// class UserResponse {
//   final List<User> users;
//   final String error;

//   UserResponse(this.users, this.error);

//   UserResponse.fromJson(Map<String, dynamic> json)
//       : users =
//             (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
//         error = "";

//   UserResponse.withError(String errorValue)
//       : users = List(),
//         error = errorValue;
// }

import 'package:prueba3_git/models/user.dart';

class UserResponse {
  final User unUsuario;
  final String error;

  UserResponse(this.unUsuario, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : unUsuario = (json["results"]).map((i) => new User.fromJson(i)),
        error = "";

  UserResponse.withError(String errorValue)
      : unUsuario = User(),
        error = errorValue;
}

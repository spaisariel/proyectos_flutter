import 'package:prueba3_git/models/user.dart';

class UserResponse {
  final List<User> users;
  final String error;

  UserResponse(this.users, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : users =
            (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
        error = "";

  UserResponse.withError(String errorValue)
      : users = List(),
        error = errorValue;
}

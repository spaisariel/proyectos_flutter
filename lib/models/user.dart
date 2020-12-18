import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.token,
    this.userInfo,
  });

  String token;
  UserInfo userInfo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["Token"],
        userInfo: UserInfo.fromJson(json["UserInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "Token": token,
        "UserInfo": userInfo.toJson(),
      };
}

class UserInfo {
  UserInfo({
    this.id,
    this.idDevice,
    this.firstName,
    this.lastName,
    this.status,
    this.dni,
    this.email,
    this.phone,
    this.role,
    this.changePass,
    this.addresses,
  });

  String id;
  String idDevice;
  String firstName;
  String lastName;
  String status;
  String dni;
  String email;
  String phone;
  String role;
  bool changePass;
  String addresses;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["Id"],
        idDevice: json["IdDevice"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        status: json["Status"],
        dni: json["Dni"],
        email: json["Email"],
        phone: json["Phone"],
        role: json["Role"],
        changePass: json["ChangePass"],
        addresses: json["Addresses"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IdDevice": idDevice,
        "FirstName": firstName,
        "LastName": lastName,
        "Status": status,
        "Dni": dni,
        "Email": email,
        "Phone": phone,
        "Role": role,
        "ChangePass": changePass,
        "Addresses": addresses,
      };
}

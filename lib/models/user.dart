// import 'dart:convert';

// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

// class User {
//   User({
//     this.id,
//     this.nombre,
//     this.apellido,
//     this.mail,
//     this.telefono,
//     this.direccion,
//     this.cuit,
//   });

//   int id;
//   String nombre;
//   String apellido;
//   String mail;
//   String telefono;
//   String direccion;
//   String cuit;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         nombre: json["nombre"],
//         apellido: json["apellido"],
//         mail: json["mail"],
//         telefono: json["telefono"],
//         direccion: json["direccion"],
//         cuit: json["cuit"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nombre": nombre,
//         "apellido": apellido,
//         "mail": mail,
//         "telefono": telefono,
//         "direccion": direccion,
//         "cuit": cuit,
//       };
// }

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
  dynamic idDevice;
  String firstName;
  String lastName;
  String status;
  String dni;
  String email;
  dynamic phone;
  String role;
  bool changePass;
  dynamic addresses;

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

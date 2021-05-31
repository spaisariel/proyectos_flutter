import 'dart:convert';

Chart chartFromJson(String str) => Chart.fromJson(json.decode(str));

String chartToJson(Chart data) => json.encode(data.toJson());

class Chart {
  Chart({
    this.datos,
    this.categorias,
    this.referenciaejex,
    this.referenciaejey,
    this.referenciaclick,
    this.tipoGrafico,
    this.titulo,
    this.min,
    this.max,
  });

  List<Dato> datos;
  List<String> categorias;
  String referenciaejex;
  String referenciaejey;
  String referenciaclick;
  String tipoGrafico;
  String titulo;
  int min;
  int max;

  // factory Chart.fromJson(Map<String, dynamic> json) => Chart(
  //       datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
  //       categorias: List<String>.from(json["categorias"].map((x) => x)),
  //       referenciaejex: json["referenciaejex"],
  //       referenciaejey: json["referenciaejey"],
  //       referenciaclick: json["referenciaclick"],
  //       tipoGrafico: json["tipoGrafico"],
  //       titulo: json["titulo"],
  //       min: json["min"],
  //       max: json["max"],
  //     );

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        datos: json["datos"] == null
            ? null
            : List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
        categorias: json["categorias"] == null
            ? null
            : List<String>.from(json["categorias"].map((x) => x)),
        referenciaejex:
            json["referenciaejex"] == null ? null : json["referenciaejex"],
        referenciaejey:
            json["referenciaejey"] == null ? null : json["referenciaejey"],
        referenciaclick:
            json["referenciaclick"] == null ? null : json["referenciaclick"],
        tipoGrafico: json["tipoGrafico"] == null ? null : json["tipoGrafico"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        min: json["min"] == null ? null : json["min"],
        max: json["max"] == null ? null : json["max"],
      );

  // Map<String, dynamic> toJson() => {
  //       "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  //       "categorias": List<dynamic>.from(categorias.map((x) => x)),
  //       "referenciaejex": referenciaejex,
  //       "referenciaejey": referenciaejey,
  //       "referenciaclick": referenciaclick,
  //       "tipoGrafico": tipoGrafico,
  //       "titulo": titulo,
  //       "min": min,
  //       "max": max,
  //     };

  Map<String, dynamic> toJson() => {
        "datos": datos == null
            ? null
            : List<dynamic>.from(datos.map((x) => x.toJson())),
        "categorias": categorias == null
            ? null
            : List<dynamic>.from(categorias.map((x) => x)),
        "referenciaejex": referenciaejex == null ? null : referenciaejex,
        "referenciaejey": referenciaejey == null ? null : referenciaejey,
        "referenciaclick": referenciaclick == null ? null : referenciaclick,
        "tipoGrafico": tipoGrafico == null ? null : tipoGrafico,
        "titulo": titulo == null ? null : titulo,
        "min": min == null ? null : min,
        "max": max == null ? null : max,
      };
}

class Dato {
  Dato({
    this.name,
    this.data,
    this.data2,
  });

  String name;
  List<int> data;
  List<Data2> data2;

  // factory Dato.fromJson(Map<String, dynamic> json) => Dato(
  //       name: json["name"],
  //       data: List<int>.from(json["data"].map((x) => x)),
  //       data2: List<Data2>.from(json["data2"].map((x) => Data2.fromJson(x))),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "data": List<dynamic>.from(data.map((x) => x)),
  //       "data2": List<dynamic>.from(data2.map((x) => x.toJson())),
  //     };

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        name: json["name"] == null ? null : json["name"],
        data: json["data"] == null
            ? null
            : List<int>.from(json["data"].map((x) => x)),
        data2: json["data2"] == null
            ? null
            : List<Data2>.from(json["data2"].map((x) => Data2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "data2": data2 == null
            ? null
            : List<dynamic>.from(data2.map((x) => x.toJson())),
      };
}

class Data2 {
  Data2({
    this.y,
    this.name,
  });

  int y;
  String name;

  // factory Data2.fromJson(Map<String, dynamic> json) => Data2(
  //       y: json["y"],
  //       name: json["name"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "y": y,
  //       "name": name,
  //     };

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        y: json["y"] == null ? null : json["y"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "y": y == null ? null : y,
        "name": name == null ? null : name,
      };
}

Perfil perfilFromJson(String str) => Perfil.fromJson(json.decode(str));

String perfilToJson(Perfil data) => json.encode(data.toJson());

class Perfil {
  Perfil({
    this.codigoPerfil,
    this.nombre,
    this.consultasPersonalizadas,
    this.consultasDashboard,
  });

  String codigoPerfil;
  String nombre;
  List<ConsultasPersonalizada> consultasPersonalizadas;
  dynamic consultasDashboard;

  factory Perfil.fromJson(Map<String, dynamic> json) => Perfil(
        codigoPerfil: json["codigoPerfil"],
        nombre: json["nombre"],
        consultasPersonalizadas: List<ConsultasPersonalizada>.from(
            json["consultasPersonalizadas"]
                .map((x) => ConsultasPersonalizada.fromJson(x))),
        consultasDashboard: json["consultasDashboard"],
      );

  Map<String, dynamic> toJson() => {
        "codigoPerfil": codigoPerfil,
        "nombre": nombre,
        "consultasPersonalizadas":
            List<dynamic>.from(consultasPersonalizadas.map((x) => x.toJson())),
        "consultasDashboard": consultasDashboard,
      };
}

class ConsultasPersonalizada {
  ConsultasPersonalizada({
    this.codigoConsulta,
    this.descripcion,
    this.sql,
  });

  String codigoConsulta;
  String descripcion;
  String sql;

  factory ConsultasPersonalizada.fromJson(Map<String, dynamic> json) =>
      ConsultasPersonalizada(
        codigoConsulta: json["codigoConsulta"],
        descripcion: json["descripcion"],
        sql: json["sql"],
      );

  Map<String, dynamic> toJson() => {
        "codigoConsulta": codigoConsulta,
        "descripcion": descripcion,
        "sql": sql,
      };
}

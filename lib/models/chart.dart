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

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
        categorias: List<String>.from(json["categorias"].map((x) => x)),
        referenciaejex: json["referenciaejex"],
        referenciaejey: json["referenciaejey"],
        referenciaclick: json["referenciaclick"],
        tipoGrafico: json["tipoGrafico"],
        titulo: json["titulo"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
        "categorias": List<dynamic>.from(categorias.map((x) => x)),
        "referenciaejex": referenciaejex,
        "referenciaejey": referenciaejey,
        "referenciaclick": referenciaclick,
        "tipoGrafico": tipoGrafico,
        "titulo": titulo,
        "min": min,
        "max": max,
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
  dynamic data2;

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        name: json["name"],
        data: List<int>.from(json["data"].map((x) => x)),
        data2: json["data2"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x)),
        "data2": data2,
      };
}

Perfil perfilFromJson(String str) => Perfil.fromJson(json.decode(str));

String perfilToJson(Perfil data) => json.encode(data.toJson());

class Perfil {
  Perfil({
    this.codigoPerfil,
    this.nombre,
    this.consultasDashboard,
    this.consultasPersonalizadas,
  });

  String codigoPerfil;
  String nombre;
  List<ConsultasDashboard> consultasDashboard;
  dynamic consultasPersonalizadas;

  factory Perfil.fromJson(Map<String, dynamic> json) => Perfil(
        codigoPerfil: json["codigoPerfil"],
        nombre: json["nombre"],
        consultasDashboard: List<ConsultasDashboard>.from(
            json["consultasDashboard"]
                .map((x) => ConsultasDashboard.fromJson(x))),
        consultasPersonalizadas: json["consultasPersonalizadas"],
      );

  Map<String, dynamic> toJson() => {
        "codigoPerfil": codigoPerfil,
        "nombre": nombre,
        "consultasDashboard":
            List<dynamic>.from(consultasDashboard.map((x) => x.toJson())),
        "consultasPersonalizadas": consultasPersonalizadas,
      };
}

class ConsultasDashboard {
  ConsultasDashboard({
    this.codigoConsulta,
    this.descripcion,
    this.sql,
    this.orden,
  });

  String codigoConsulta;
  String descripcion;
  dynamic sql;
  int orden;

  factory ConsultasDashboard.fromJson(Map<String, dynamic> json) =>
      ConsultasDashboard(
        codigoConsulta: json["codigoConsulta"],
        descripcion: json["descripcion"],
        sql: json["sql"],
        orden: json["orden"],
      );

  Map<String, dynamic> toJson() => {
        "codigoConsulta": codigoConsulta,
        "descripcion": descripcion,
        "sql": sql,
        "orden": orden,
      };
}

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Product {
//   Product({
//     this.idCodigo,
//     this.descripcion,
//     this.unidadPorBulto,
//     this.costo,
//     this.existencia,
//     this.precioPresentacion,
//     this.precioLista,
//     this.existenciaDepositos,
//   });

//   int idCodigo;
//   String descripcion;
//   String unidadPorBulto;
//   String costo;
//   String existencia;
//   String precioPresentacion;
//   String precioLista;
//   ExistenciaDepositos existenciaDepositos;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         idCodigo: json["idCodigo"],
//         descripcion: json["descripcion"],
//         unidadPorBulto: json["unidadPorBulto"],
//         costo: json["costo"],
//         existencia: json["existencia"],
//         precioPresentacion: json["precioPresentacion"],
//         precioLista: json["precioLista"],
//         existenciaDepositos:
//             ExistenciaDepositos.fromJson(json["existenciaDepositos"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "idCodigo": idCodigo,
//         "descripcion": descripcion,
//         "unidadPorBulto": unidadPorBulto,
//         "costo": costo,
//         "existencia": existencia,
//         "precioPresentacion": precioPresentacion,
//         "precioLista": precioLista,
//         "existenciaDepositos": existenciaDepositos.toJson(),
//       };
// }

// class ExistenciaDepositos {
//   ExistenciaDepositos({
//     this.deposito,
//     this.sucursal,
//     this.existenciaOtroLugar,
//     this.presentacion,
//   });

//   String deposito;
//   String sucursal;
//   String existenciaOtroLugar;
//   String presentacion;

//   factory ExistenciaDepositos.fromJson(Map<String, dynamic> json) =>
//       ExistenciaDepositos(
//         deposito: json["deposito"],
//         sucursal: json["sucursal"],
//         existenciaOtroLugar: json["existenciaOtroLugar"],
//         presentacion: json["presentacion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "deposito": deposito,
//         "sucursal": sucursal,
//         "existenciaOtroLugar": existenciaOtroLugar,
//         "presentacion": presentacion,
//       };
// }

//import 'dart:convert';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

// String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.prices,
    this.id,
    this.name,
    this.subcategorieId,
    this.subcategorieName,
    this.stock,
    this.price,
    this.priceToShow,
    this.image,
    this.description,
    this.info,
    this.score,
    this.priceId,
    this.includesIva,
    this.sales,
    this.unitsPerPackage,
    this.webDescription,
    this.order,
    this.containsVariations,
    this.store,
  });

  List<Price> prices;
  String id;
  String name;
  String subcategorieId;
  String subcategorieName;
  double stock;
  double price;
  double priceToShow;
  String image;
  String description;
  String info;
  int score;
  String priceId;
  dynamic includesIva;
  int sales;
  double unitsPerPackage;
  String webDescription;
  int order;
  bool containsVariations;
  dynamic store;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        prices: List<Price>.from(json["Prices"].map((x) => Price.fromJson(x))),
        id: json["Id"],
        name: json["Name"],
        subcategorieId: json["SubcategorieId"],
        subcategorieName: json["SubcategorieName"],
        stock: json["Stock"],
        price: json["Price"],
        priceToShow: json["PriceToShow"],
        image: json["Image"],
        description: json["Description"],
        info: json["Info"],
        score: json["Score"],
        priceId: json["PriceId"],
        includesIva: json["IncludesIVA"],
        sales: json["Sales"],
        unitsPerPackage: json["UnitsPerPackage"],
        webDescription: json["WebDescription"],
        order: json["Order"],
        containsVariations: json["ContainsVariations"],
        store: json["Store"],
      );

  Map<String, dynamic> toJson() => {
        "Prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "Id": id,
        "Name": name,
        "SubcategorieId": subcategorieId,
        "SubcategorieName": subcategorieName,
        "Stock": stock,
        "Price": price,
        "PriceToShow": priceToShow,
        "Image": image,
        "Description": description,
        "Info": info,
        "Score": score,
        "PriceId": priceId,
        "IncludesIVA": includesIva,
        "Sales": sales,
        "UnitsPerPackage": unitsPerPackage,
        "WebDescription": webDescription,
        "Order": order,
        "ContainsVariations": containsVariations,
        "Store": store,
      };
}

class Price {
  Price({
    this.price,
    this.priceName,
    this.presentation,
    this.isSale,
  });

  double price;
  String priceName;
  String presentation;
  bool isSale;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: json["Price"].toDouble(),
        priceName: json["PriceName"],
        presentation: json["Presentation"],
        isSale: json["isSale"],
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "PriceName": priceName,
        "Presentation": presentation,
        "isSale": isSale,
      };
}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

// import 'dart:convert';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

// String productToJson(Product data) => json.encode(data.toJson());

// class Product {
//   Product({
//     this.totalRegistros,
//     this.items,
//     this.inicio,
//     this.limite,
//   });

//   int totalRegistros;
//   List<Item> items;
//   int inicio;
//   int limite;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         totalRegistros: json["totalRegistros"],
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         inicio: json["inicio"],
//         limite: json["limite"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalRegistros": totalRegistros,
//         "items": List<dynamic>.from(items.map((x) => x.toJson())),
//         "inicio": inicio,
//         "limite": limite,
//       };
// }

// class Item {
//   Item({
//     this.codigo,
//     this.nombre,
//     this.etiqueta,
//     this.activo,
//     this.activoDesdeFechaYHora,
//     this.activoHastaFechaYHora,
//     this.cambioDescripcionAlVender,
//     this.saleEnListaPrecio,
//     this.observaciones,
//     this.codigoProveedorHabitual,
//     this.codigoIva,
//     this.importeImpuestoInternoPorUnidadDeStock,
//     this.costo,
//     this.controlPartidas,
//     this.codigoProveedorAlternativo,
//     this.importeFijoTgv,
//     this.fechaAlta,
//     this.publicoEnTiendaVirtual,
//     this.publicoEnApp,
//     this.publicoEnMercadoLibre,
//     this.descripcionWeb,
//     this.tagsWeb,
//     this.peso,
//     this.codigoUnidadMedidaPeso,
//     this.medidaLargo,
//     this.medidaAncho,
//     this.medidaAlto,
//     this.codigoUnidadMedidaDeLasMedidas,
//     this.codigoInterno,
//     this.codigoArticuloDeReemplazo,
//     this.codigoPresentacionStock,
//     this.codigoPresentacionVenta,
//     this.codigoPresentacionCompra,
//     this.codigoPresentacionReparto,
//     this.codigoImpuestoInterno,
//     this.codigoTvg,
//     this.afectaCentroCostos,
//     this.permiteModificarDescripcionEnOperacion,
//     this.foto,
//     this.actualizaStock,
//     this.produccionPropia,
//     this.permiteModificarEnOperacion,
//     this.codigoFotoPorDefecto,
//     this.puntajeCompra,
//     this.puntajeCanje,
//     this.ventaPorBulto,
//     this.codigoMonedaCosto,
//     this.bonificacionUno,
//     this.bonificacionDos,
//     this.bonificacionTres,
//     this.bonificacionCuatro,
//     this.recargoUno,
//     this.recargoDos,
//     this.recargoTres,
//     this.recargoCuatro,
//     this.codigoStockPrincipalParaVariante,
//     this.controlaStockAlEmitirComprobante,
//     this.monedaCosto,
//     this.fotoPorDefecto,
//     this.proveedor,
//     this.iva,
//     this.proveedorAlternativo,
//     this.articuloDeReemplazo,
//     this.presentacionStock,
//     this.presentacionVenta,
//     this.presentacionCompra,
//     this.presentacionReparto,
//     this.impuestoInterno,
//     this.tvg,
//     this.tipoArticulo,
//     this.metodoParaCalculoDeCosto,
//     this.presentaciones,
//     this.caracteristicas,
//     this.preciosVenta,
//     this.preciosCompra,
//     this.precios,
//     this.existencia,
//     this.existenciaTotal,
//     this.codigoMarca,
//     this.marca,
//     this.unidadMedidaPeso,
//     this.unidadMedidaDeLasMedidas,
//     this.articuloPrincipalParaVariante,
//     this.precio,
//   });

//   String codigo;
//   String nombre;
//   dynamic etiqueta;
//   bool activo;
//   dynamic activoDesdeFechaYHora;
//   dynamic activoHastaFechaYHora;
//   bool cambioDescripcionAlVender;
//   bool saleEnListaPrecio;
//   dynamic observaciones;
//   dynamic codigoProveedorHabitual;
//   dynamic codigoIva;
//   int importeImpuestoInternoPorUnidadDeStock;
//   int costo;
//   bool controlPartidas;
//   dynamic codigoProveedorAlternativo;
//   int importeFijoTgv;
//   DateTime fechaAlta;
//   bool publicoEnTiendaVirtual;
//   dynamic publicoEnApp;
//   dynamic publicoEnMercadoLibre;
//   dynamic descripcionWeb;
//   dynamic tagsWeb;
//   dynamic peso;
//   dynamic codigoUnidadMedidaPeso;
//   dynamic medidaLargo;
//   dynamic medidaAncho;
//   dynamic medidaAlto;
//   dynamic codigoUnidadMedidaDeLasMedidas;
//   dynamic codigoInterno;
//   dynamic codigoArticuloDeReemplazo;
//   dynamic codigoPresentacionStock;
//   CodigoPresentacionVenta codigoPresentacionVenta;
//   dynamic codigoPresentacionCompra;
//   dynamic codigoPresentacionReparto;
//   dynamic codigoImpuestoInterno;
//   dynamic codigoTvg;
//   bool afectaCentroCostos;
//   bool permiteModificarDescripcionEnOperacion;
//   dynamic foto;
//   dynamic actualizaStock;
//   dynamic produccionPropia;
//   dynamic permiteModificarEnOperacion;
//   dynamic codigoFotoPorDefecto;
//   dynamic puntajeCompra;
//   dynamic puntajeCanje;
//   dynamic ventaPorBulto;
//   dynamic codigoMonedaCosto;
//   dynamic bonificacionUno;
//   dynamic bonificacionDos;
//   dynamic bonificacionTres;
//   dynamic bonificacionCuatro;
//   dynamic recargoUno;
//   dynamic recargoDos;
//   dynamic recargoTres;
//   dynamic recargoCuatro;
//   dynamic codigoStockPrincipalParaVariante;
//   dynamic controlaStockAlEmitirComprobante;
//   dynamic monedaCosto;
//   dynamic fotoPorDefecto;
//   dynamic proveedor;
//   dynamic iva;
//   dynamic proveedorAlternativo;
//   dynamic articuloDeReemplazo;
//   dynamic presentacionStock;
//   PresentacionVenta presentacionVenta;
//   dynamic presentacionCompra;
//   dynamic presentacionReparto;
//   dynamic impuestoInterno;
//   dynamic tvg;
//   dynamic tipoArticulo;
//   dynamic metodoParaCalculoDeCosto;
//   dynamic presentaciones;
//   dynamic caracteristicas;
//   List<PreciosVenta> preciosVenta;
//   dynamic preciosCompra;
//   dynamic precios;
//   List<Existencia> existencia;
//   int existenciaTotal;
//   dynamic codigoMarca;
//   dynamic marca;
//   dynamic unidadMedidaPeso;
//   dynamic unidadMedidaDeLasMedidas;
//   dynamic articuloPrincipalParaVariante;
//   dynamic precio;

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         codigo: json["Codigo"],
//         nombre: json["Nombre"],
//         etiqueta: json["Etiqueta"],
//         activo: json["Activo"],
//         activoDesdeFechaYHora: json["ActivoDesdeFechaYHora"],
//         activoHastaFechaYHora: json["ActivoHastaFechaYHora"],
//         cambioDescripcionAlVender: json["CambioDescripcionAlVender"],
//         saleEnListaPrecio: json["SaleEnListaPrecio"],
//         observaciones: json["Observaciones"],
//         codigoProveedorHabitual: json["CodigoProveedorHabitual"],
//         codigoIva: json["CodigoIva"],
//         importeImpuestoInternoPorUnidadDeStock:
//             json["ImporteImpuestoInternoPorUnidadDeStock"],
//         costo: json["Costo"],
//         controlPartidas: json["ControlPartidas"],
//         codigoProveedorAlternativo: json["CodigoProveedorAlternativo"],
//         importeFijoTgv: json["ImporteFijoTgv"],
//         fechaAlta: DateTime.parse(json["FechaAlta"]),
//         publicoEnTiendaVirtual: json["PublicoEnTiendaVirtual"],
//         publicoEnApp: json["PublicoEnApp"],
//         publicoEnMercadoLibre: json["PublicoEnMercadoLibre"],
//         descripcionWeb: json["DescripcionWeb"],
//         tagsWeb: json["TagsWeb"],
//         peso: json["Peso"],
//         codigoUnidadMedidaPeso: json["CodigoUnidadMedidaPeso"],
//         medidaLargo: json["MedidaLargo"],
//         medidaAncho: json["MedidaAncho"],
//         medidaAlto: json["MedidaAlto"],
//         codigoUnidadMedidaDeLasMedidas: json["CodigoUnidadMedidaDeLasMedidas"],
//         codigoInterno: json["CodigoInterno"],
//         codigoArticuloDeReemplazo: json["CodigoArticuloDeReemplazo"],
//         codigoPresentacionStock: json["CodigoPresentacionStock"],
//         codigoPresentacionVenta:
//             codigoPresentacionVentaValues.map[json["CodigoPresentacionVenta"]],
//         codigoPresentacionCompra: json["CodigoPresentacionCompra"],
//         codigoPresentacionReparto: json["CodigoPresentacionReparto"],
//         codigoImpuestoInterno: json["CodigoImpuestoInterno"],
//         codigoTvg: json["CodigoTvg"],
//         afectaCentroCostos: json["AfectaCentroCostos"],
//         permiteModificarDescripcionEnOperacion:
//             json["PermiteModificarDescripcionEnOperacion"],
//         foto: json["Foto"],
//         actualizaStock: json["ActualizaStock"],
//         produccionPropia: json["ProduccionPropia"],
//         permiteModificarEnOperacion: json["PermiteModificarEnOperacion"],
//         codigoFotoPorDefecto: json["CodigoFotoPorDefecto"],
//         puntajeCompra: json["puntajeCompra"],
//         puntajeCanje: json["puntajeCanje"],
//         ventaPorBulto: json["ventaPorBulto"],
//         codigoMonedaCosto: json["codigoMonedaCosto"],
//         bonificacionUno: json["bonificacionUno"],
//         bonificacionDos: json["bonificacionDos"],
//         bonificacionTres: json["bonificacionTres"],
//         bonificacionCuatro: json["bonificacionCuatro"],
//         recargoUno: json["recargoUno"],
//         recargoDos: json["recargoDos"],
//         recargoTres: json["recargoTres"],
//         recargoCuatro: json["recargoCuatro"],
//         codigoStockPrincipalParaVariante:
//             json["CodigoStockPrincipalParaVariante"],
//         controlaStockAlEmitirComprobante:
//             json["controlaStockAlEmitirComprobante"],
//         monedaCosto: json["monedaCosto"],
//         fotoPorDefecto: json["FotoPorDefecto"],
//         proveedor: json["Proveedor"],
//         iva: json["Iva"],
//         proveedorAlternativo: json["ProveedorAlternativo"],
//         articuloDeReemplazo: json["ArticuloDeReemplazo"],
//         presentacionStock: json["PresentacionStock"],
//         presentacionVenta:
//             PresentacionVenta.fromJson(json["PresentacionVenta"]),
//         presentacionCompra: json["PresentacionCompra"],
//         presentacionReparto: json["PresentacionReparto"],
//         impuestoInterno: json["ImpuestoInterno"],
//         tvg: json["Tvg"],
//         tipoArticulo: json["TipoArticulo"],
//         metodoParaCalculoDeCosto: json["MetodoParaCalculoDeCosto"],
//         presentaciones: json["Presentaciones"],
//         caracteristicas: json["Caracteristicas"],
//         preciosVenta: List<PreciosVenta>.from(
//             json["PreciosVenta"].map((x) => PreciosVenta.fromJson(x))),
//         preciosCompra: json["PreciosCompra"],
//         precios: json["Precios"],
//         existencia: List<Existencia>.from(
//             json["Existencia"].map((x) => Existencia.fromJson(x))),
//         existenciaTotal: json["ExistenciaTotal"],
//         codigoMarca: json["CodigoMarca"],
//         marca: json["Marca"],
//         unidadMedidaPeso: json["UnidadMedidaPeso"],
//         unidadMedidaDeLasMedidas: json["UnidadMedidaDeLasMedidas"],
//         articuloPrincipalParaVariante: json["ArticuloPrincipalParaVariante"],
//         precio: json["Precio"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Codigo": codigo,
//         "Nombre": nombre,
//         "Etiqueta": etiqueta,
//         "Activo": activo,
//         "ActivoDesdeFechaYHora": activoDesdeFechaYHora,
//         "ActivoHastaFechaYHora": activoHastaFechaYHora,
//         "CambioDescripcionAlVender": cambioDescripcionAlVender,
//         "SaleEnListaPrecio": saleEnListaPrecio,
//         "Observaciones": observaciones,
//         "CodigoProveedorHabitual": codigoProveedorHabitual,
//         "CodigoIva": codigoIva,
//         "ImporteImpuestoInternoPorUnidadDeStock":
//             importeImpuestoInternoPorUnidadDeStock,
//         "Costo": costo,
//         "ControlPartidas": controlPartidas,
//         "CodigoProveedorAlternativo": codigoProveedorAlternativo,
//         "ImporteFijoTgv": importeFijoTgv,
//         "FechaAlta": fechaAlta.toIso8601String(),
//         "PublicoEnTiendaVirtual": publicoEnTiendaVirtual,
//         "PublicoEnApp": publicoEnApp,
//         "PublicoEnMercadoLibre": publicoEnMercadoLibre,
//         "DescripcionWeb": descripcionWeb,
//         "TagsWeb": tagsWeb,
//         "Peso": peso,
//         "CodigoUnidadMedidaPeso": codigoUnidadMedidaPeso,
//         "MedidaLargo": medidaLargo,
//         "MedidaAncho": medidaAncho,
//         "MedidaAlto": medidaAlto,
//         "CodigoUnidadMedidaDeLasMedidas": codigoUnidadMedidaDeLasMedidas,
//         "CodigoInterno": codigoInterno,
//         "CodigoArticuloDeReemplazo": codigoArticuloDeReemplazo,
//         "CodigoPresentacionStock": codigoPresentacionStock,
//         "CodigoPresentacionVenta":
//             codigoPresentacionVentaValues.reverse[codigoPresentacionVenta],
//         "CodigoPresentacionCompra": codigoPresentacionCompra,
//         "CodigoPresentacionReparto": codigoPresentacionReparto,
//         "CodigoImpuestoInterno": codigoImpuestoInterno,
//         "CodigoTvg": codigoTvg,
//         "AfectaCentroCostos": afectaCentroCostos,
//         "PermiteModificarDescripcionEnOperacion":
//             permiteModificarDescripcionEnOperacion,
//         "Foto": foto,
//         "ActualizaStock": actualizaStock,
//         "ProduccionPropia": produccionPropia,
//         "PermiteModificarEnOperacion": permiteModificarEnOperacion,
//         "CodigoFotoPorDefecto": codigoFotoPorDefecto,
//         "puntajeCompra": puntajeCompra,
//         "puntajeCanje": puntajeCanje,
//         "ventaPorBulto": ventaPorBulto,
//         "codigoMonedaCosto": codigoMonedaCosto,
//         "bonificacionUno": bonificacionUno,
//         "bonificacionDos": bonificacionDos,
//         "bonificacionTres": bonificacionTres,
//         "bonificacionCuatro": bonificacionCuatro,
//         "recargoUno": recargoUno,
//         "recargoDos": recargoDos,
//         "recargoTres": recargoTres,
//         "recargoCuatro": recargoCuatro,
//         "CodigoStockPrincipalParaVariante": codigoStockPrincipalParaVariante,
//         "controlaStockAlEmitirComprobante": controlaStockAlEmitirComprobante,
//         "monedaCosto": monedaCosto,
//         "FotoPorDefecto": fotoPorDefecto,
//         "Proveedor": proveedor,
//         "Iva": iva,
//         "ProveedorAlternativo": proveedorAlternativo,
//         "ArticuloDeReemplazo": articuloDeReemplazo,
//         "PresentacionStock": presentacionStock,
//         "PresentacionVenta": presentacionVenta.toJson(),
//         "PresentacionCompra": presentacionCompra,
//         "PresentacionReparto": presentacionReparto,
//         "ImpuestoInterno": impuestoInterno,
//         "Tvg": tvg,
//         "TipoArticulo": tipoArticulo,
//         "MetodoParaCalculoDeCosto": metodoParaCalculoDeCosto,
//         "Presentaciones": presentaciones,
//         "Caracteristicas": caracteristicas,
//         "PreciosVenta": List<dynamic>.from(preciosVenta.map((x) => x.toJson())),
//         "PreciosCompra": preciosCompra,
//         "Precios": precios,
//         "Existencia": List<dynamic>.from(existencia.map((x) => x.toJson())),
//         "ExistenciaTotal": existenciaTotal,
//         "CodigoMarca": codigoMarca,
//         "Marca": marca,
//         "UnidadMedidaPeso": unidadMedidaPeso,
//         "UnidadMedidaDeLasMedidas": unidadMedidaDeLasMedidas,
//         "ArticuloPrincipalParaVariante": articuloPrincipalParaVariante,
//         "Precio": precio,
//       };
// }

// enum CodigoPresentacionVenta { UNIDAD }

// final codigoPresentacionVentaValues =
//     EnumValues({"Unidad": CodigoPresentacionVenta.UNIDAD});

// class Existencia {
//   Existencia({
//     this.codigoDeposito,
//     this.nombreDeposito,
//     this.nombreSucursal,
//     this.existencia,
//     this.presentacionArticulo,
//     this.prioridadDeDescuentoStock,
//   });

//   String codigoDeposito;
//   NombreDeposito nombreDeposito;
//   NombreSucursal nombreSucursal;
//   int existencia;
//   CodigoPresentacionVenta presentacionArticulo;
//   dynamic prioridadDeDescuentoStock;

//   factory Existencia.fromJson(Map<String, dynamic> json) => Existencia(
//         codigoDeposito: json["codigoDeposito"],
//         nombreDeposito: nombreDepositoValues.map[json["nombreDeposito"]],
//         nombreSucursal: json["nombreSucursal"] == null
//             ? null
//             : nombreSucursalValues.map[json["nombreSucursal"]],
//         existencia: json["existencia"],
//         presentacionArticulo: json["presentacionArticulo"] == null
//             ? null
//             : codigoPresentacionVentaValues.map[json["presentacionArticulo"]],
//         prioridadDeDescuentoStock: json["prioridadDeDescuentoStock"],
//       );

//   Map<String, dynamic> toJson() => {
//         "codigoDeposito": codigoDeposito,
//         "nombreDeposito": nombreDepositoValues.reverse[nombreDeposito],
//         "nombreSucursal": nombreSucursal == null
//             ? null
//             : nombreSucursalValues.reverse[nombreSucursal],
//         "existencia": existencia,
//         "presentacionArticulo": presentacionArticulo == null
//             ? null
//             : codigoPresentacionVentaValues.reverse[presentacionArticulo],
//         "prioridadDeDescuentoStock": prioridadDeDescuentoStock,
//       };
// }

// enum NombreDeposito { LA_PLAYA, FEDERICO_BANDI }

// final nombreDepositoValues = EnumValues({
//   "Federico  Bandi": NombreDeposito.FEDERICO_BANDI,
//   "La playa": NombreDeposito.LA_PLAYA
// });

// enum NombreSucursal { PARAN }

// final nombreSucursalValues = EnumValues({"Paraná": NombreSucursal.PARAN});

// class PreciosVenta {
//   PreciosVenta({
//     this.id,
//     this.codigoListaPrecios,
//     this.esVenta,
//     this.presentacionLabel,
//     this.listaPrecios,
//     this.codigoPresentacion,
//     this.presentacion,
//     this.monedaSimbolo,
//     this.precioUnitario,
//     this.precioUnitarioConIva,
//     this.precioUnitarioSinIva,
//     this.fechaUltimaModificacion,
//     this.fechaHoraUltimaModificacion,
//   });

//   int id;
//   String codigoListaPrecios;
//   bool esVenta;
//   dynamic presentacionLabel;
//   ListaPrecios listaPrecios;
//   dynamic codigoPresentacion;
//   dynamic presentacion;
//   dynamic monedaSimbolo;
//   int precioUnitario;
//   double precioUnitarioConIva;
//   double precioUnitarioSinIva;
//   dynamic fechaUltimaModificacion;
//   dynamic fechaHoraUltimaModificacion;

//   factory PreciosVenta.fromJson(Map<String, dynamic> json) => PreciosVenta(
//         id: json["id"],
//         codigoListaPrecios: json["codigoListaPrecios"],
//         esVenta: json["esVenta"],
//         presentacionLabel: json["presentacionLabel"],
//         listaPrecios: ListaPrecios.fromJson(json["listaPrecios"]),
//         codigoPresentacion: json["codigoPresentacion"],
//         presentacion: json["presentacion"],
//         monedaSimbolo: json["monedaSimbolo"],
//         precioUnitario: json["precioUnitario"],
//         precioUnitarioConIva: json["precioUnitarioConIVA"].toDouble(),
//         precioUnitarioSinIva: json["precioUnitarioSinIVA"].toDouble(),
//         fechaUltimaModificacion: json["fechaUltimaModificacion"],
//         fechaHoraUltimaModificacion: json["fechaHoraUltimaModificacion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "codigoListaPrecios": codigoListaPrecios,
//         "esVenta": esVenta,
//         "presentacionLabel": presentacionLabel,
//         "listaPrecios": listaPrecios.toJson(),
//         "codigoPresentacion": codigoPresentacion,
//         "presentacion": presentacion,
//         "monedaSimbolo": monedaSimbolo,
//         "precioUnitario": precioUnitario,
//         "precioUnitarioConIVA": precioUnitarioConIva,
//         "precioUnitarioSinIVA": precioUnitarioSinIva,
//         "fechaUltimaModificacion": fechaUltimaModificacion,
//         "fechaHoraUltimaModificacion": fechaHoraUltimaModificacion,
//       };
// }

// class ListaPrecios {
//   ListaPrecios({
//     this.codigoListaPrecios,
//     this.nombreLista,
//   });

//   String codigoListaPrecios;
//   NombreLista nombreLista;

//   factory ListaPrecios.fromJson(Map<String, dynamic> json) => ListaPrecios(
//         codigoListaPrecios: json["codigoListaPrecios"],
//         nombreLista: nombreListaValues.map[json["nombreLista"]],
//       );

//   Map<String, dynamic> toJson() => {
//         "codigoListaPrecios": codigoListaPrecios,
//         "nombreLista": nombreListaValues.reverse[nombreLista],
//       };
// }

// enum NombreLista { LISTA_MOSTRADOR, LISTA_MAYORISTA }

// final nombreListaValues = EnumValues({
//   "Lista Mayorista": NombreLista.LISTA_MAYORISTA,
//   "Lista Mostrador": NombreLista.LISTA_MOSTRADOR
// });

// class PresentacionVenta {
//   PresentacionVenta({
//     this.codigoPresentacion,
//     this.nombre,
//   });

//   CodigoPresentacionVenta codigoPresentacion;
//   CodigoPresentacionVenta nombre;

//   factory PresentacionVenta.fromJson(Map<String, dynamic> json) =>
//       PresentacionVenta(
//         codigoPresentacion:
//             codigoPresentacionVentaValues.map[json["codigoPresentacion"]],
//         nombre: codigoPresentacionVentaValues.map[json["nombre"]],
//       );

//   Map<String, dynamic> toJson() => {
//         "codigoPresentacion":
//             codigoPresentacionVentaValues.reverse[codigoPresentacion],
//         "nombre": codigoPresentacionVentaValues.reverse[nombre],
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }

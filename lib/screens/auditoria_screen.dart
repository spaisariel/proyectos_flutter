import 'package:flutter/material.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';

// ignore: must_be_immutable
class AuditoriaScreen extends StatefulWidget {
  String idSucursal;
  String idDeposito;
  List<Product> listaProductos;
  List<Reason> listaRazones;
  List<Item> listaItems;

  AuditoriaScreen(this.listaProductos, this.listaRazones, this.listaItems,
      this.idSucursal, this.idDeposito);
  @override
  _AuditoriaScreenState createState() => _AuditoriaScreenState(
      this.listaProductos,
      this.listaRazones,
      this.listaItems,
      this.idSucursal,
      this.idDeposito);
}

class _AuditoriaScreenState extends State<AuditoriaScreen> {
  String idSucursal;
  String idDeposito;
  List<Product> listaProductos;
  List<Reason> listaRazones;
  List<Item> listaItems;
  String dropdownValue;

  _AuditoriaScreenState(this.listaProductos, this.listaRazones, this.listaItems,
      this.idSucursal, this.idDeposito);

  String codeDialog = '';

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idSucursal = this.idSucursal;
    idDeposito = this.idDeposito;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text('Auditoria'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            BotonesBusquedaWidget("auditoria", listaRazones),
            SizedBox(height: 30),
            tablaProductos(listaProductos),
            SizedBox(height: 80),
            tablaPrueba(listaProductos),
            Container(
              child: botonesBusquedaWidget(context, idSucursal, idDeposito),
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }

  Widget tablaProductos(List<Product> productos) {
    return Container(
      child: DataTable(
        columnSpacing: 10, horizontalMargin: 10.0,

        //columnSpacing: 1.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'NOMBRE',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: productos
            .map(
              (producto) => DataRow(
                selected: productos.contains(producto),
                cells: [
                  DataCell(
                    Text(producto.id.toString()),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(producto.name),
                    onTap: () {},
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget tablaPrueba(List<Product> productos) {
    listaItems.forEach((item) {
      List<Reason> nombreRazon = item.reasons;

      nombreRazon.forEach((razon) {
        if (listaItems.length != 0 && listaItems.length != 0) {
          for (var i = 0; i < listaRazones.length; i++) {
            for (var o = 0; o < listaItems.length; o++) {
              List<Reason> razonesItem = new List<Reason>();
              razonesItem = listaItems[o].reasons;
              for (var p = 0; p < razonesItem.length; p++) {
                if (razonesItem[p].descripcion == listaRazones[i].descripcion) {
                  return Container(
                    child: DataTable(
                      columnSpacing: 10,
                      horizontalMargin: 10.0,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: listaItems
                          .map(
                            (item) => DataRow(
                              selected: productos.contains(item),
                              cells: [
                                DataCell(
                                  Text(item.productId),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
              }
            }
          }
        }
      });
    });

    // if (listaItems.length != 0 && listaItems.length != 0) {
    //   for (var i = 0; i < listaRazones.length; i++) {
    //     for (var o = 0; o < listaItems.length; o++) {
    //       List<Reason> razonesItem = new List<Reason>();
    //       razonesItem = listaItems[o].reasons;
    //       for (var p = 0; p < razonesItem.length; p++) {
    //         if (razonesItem[p].descripcion == listaRazones[i].descripcion) {
    //           return Container(
    //             child: DataTable(
    //               columnSpacing: 10,
    //               horizontalMargin: 10.0,
    //               columns: const <DataColumn>[
    //                 DataColumn(
    //                   label: Text(
    //                     'ID',
    //                     style: TextStyle(fontStyle: FontStyle.italic),
    //                   ),
    //                 ),
    //                 DataColumn(
    //                   label: Text(
    //                     'Nombre',
    //                     style: TextStyle(fontStyle: FontStyle.italic),
    //                   ),
    //                 ),
    //                 DataColumn(
    //                   label: Text(
    //                     'Observación',
    //                     style: TextStyle(fontStyle: FontStyle.italic),
    //                   ),
    //                 ),
    //               ],
    //               rows: listaItems
    //                   .map(
    //                     (item) => DataRow(
    //                       selected: productos.contains(item),
    //                       cells: [
    //                         DataCell(
    //                           Text(item.productId),
    //                           onTap: () {},
    //                         ),
    //                         DataCell(
    //                           Text(item.name),
    //                           onTap: () {},
    //                         ),
    //                         DataCell(
    //                           Text(item.reasons[0].observations),
    //                           onTap: () {
    //                             showDialog(
    //                                 context: context,
    //                                 builder: (BuildContext context) =>
    //                                     popUpReasons(context, item));
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                   .toList(),
    //             ),
    //           );
    //         }
    //       }
    //     }
    //   }
    // }
    return Text("No se encuentran items cargados");
  }

  Widget popUpReasons(BuildContext context, Item unItem) {
    List<Reason> razonesItem = unItem.reasons;
    String valueText;
    dropdownValue = listaRazones[0].descripcion;

    List<String> nombreRazones =
        listaRazones.map((razon) => razon.descripcion).toList();
    String id = listaRazones[0].id;
    String descripcion = dropdownValue;
    String observacion = 'No aplica';
    return new AlertDialog(
      title: const Text('Observaciones'),
      content: new Column(
        children: [
          SingleChildScrollView(
            child: DataTable(
              columnSpacing: 10,
              horizontalMargin: 10.0,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Observación',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: razonesItem
                  .map(
                    (razon) => DataRow(
                        // selected: selectedProducts.contains(producto),
                        // onSelectChanged: (b) {
                        //   onSelectedRow(b, producto);
                        // },
                        cells: [
                          DataCell(
                            Text(razon.id.toString()),
                          ),
                          DataCell(
                            Container(
                              width: 230,
                              child: Text(
                                razon.observations,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ]),
                  )
                  .toList(),
            ),
          ),
          Column(
            children: [
              TextField(
                maxLength: 50,
                onChanged: (value) {
                  setState(() {
                    valueText = value;
                    observacion = _textFieldController.text;
                  });
                },
                controller: _textFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese nueva observación',
                ),
                autofocus: false,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Style.Colors.secondColor,
                ),
                onChanged: (String newValue) {
                  setState(() {});
                },
                items:
                    nombreRazones.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Aceptar'),
                onPressed: () {
                  Reason unaRazon = new Reason();
                  unaRazon.id = id;
                  unaRazon.descripcion = descripcion;
                  unaRazon.observations = observacion;
                  unItem.reasons.add(unaRazon);
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget botonesBusquedaWidget(BuildContext context, idSucursal, idDeposito) {
    User unUsuario;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonTheme(
          buttonColor: Style.Colors.cancelColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {
                Navigator.of(context).pop();
                _showMaterialDialogCancelar(
                    context, unUsuario, idSucursal, idDeposito);
              },
              child: Column(
                children: [
                  Text('Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('auditoria',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        ),
        SizedBox(width: 20),
        ButtonTheme(
          buttonColor: Style.Colors.acceptColor2,
          height: MediaQuery.of(context).size.height * 0.07,
          minWidth: MediaQuery.of(context).size.width * 0.3,
          child: RaisedButton(
              shape: Style.Shapes.botonGrandeRoundedRectangleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopUpObservation(
                      context, unUsuario, idSucursal, idDeposito),
                );
              },
              child: Column(
                children: [
                  Text('Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('auditoria',
                      style: TextStyle(color: Colors.white, fontSize: 15))
                ],
              )),
        )
      ],
    );
  }

  _showMaterialDialogAceptar(context, unUsuario, idSucursal, idDeposito) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "Se guardo correctamente la auditoria de gondola N°"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Repository()
                        .postNuevaAuditoriaGondola(listaItems, codeDialog);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(
                                unUsuario, idSucursal, idDeposito)));
                  },
                )
              ],
            ));
  }

  _showMaterialDialogCancelar(context, unUsuario, idSucursal, idUsuario) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                  "¿Seguro desea cancelar la auditoria? Perderá los datos no guardados"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Si'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaInicial(
                                unUsuario, idSucursal, idDeposito)));
                  },
                ),
              ],
            ));
  }

  Widget _buildPopUpObservation(
      BuildContext context, unUsuario, idSucursal, idDeposito) {
    String valueText;

    return new AlertDialog(
      title: const Text('Ingrese una observación'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Observación'),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.green,
          textColor: Colors.white,
          child: Text('Aceptar'),
          onPressed: () {
            setState(() {
              codeDialog = valueText;
              _showMaterialDialogAceptar(
                  context, unUsuario, idSucursal, idDeposito);
            });
          },
        )
      ],
    );
  }
}

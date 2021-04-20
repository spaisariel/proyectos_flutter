import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_auditoria_bloc.dart';
import 'package:prueba3_git/models/auditoria.dart';
import 'package:prueba3_git/models/auditoria_response.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';
import 'package:prueba3_git/widgets/botones_principal_widget.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

// ignore: must_be_immutable
class StockScreen extends StatefulWidget {
  String idSucursal;
  String idDeposito;
  StockScreen(this.idSucursal, this.idDeposito);
  @override
  _StockScreenState createState() =>
      _StockScreenState(this.idSucursal, this.idDeposito);
}

class _StockScreenState extends State<StockScreen> {
  String idSucursal;
  String idDeposito;

  List<Reason> listaRazones;
  List<Product> listaProductos = [];

  @override
  void initState() {
    super.initState();
    razonesListBloc..getRazonesLista();
  }

  _StockScreenState(this.idSucursal, this.idDeposito);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReasonResponse>(
      stream: razonesListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ReasonResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(ReasonResponse data) {
    listaRazones = data.razones;
    return Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
            title: Text('Stock'),
            centerTitle: true,
            backgroundColor: Style.Colors.mainColor,
            leading: new WillPopScope(
                onWillPop: () async => false, child: Text(''))),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            BotonesBusquedaWidget("comun", listaRazones, listaProductos),
            SizedBox(height: 20),
            BotonesPrincipalWidget(idSucursal, idDeposito, listaRazones),
          ],
        )));
  }
}

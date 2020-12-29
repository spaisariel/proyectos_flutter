import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_product_bloc.dart';
import 'package:prueba3_git/models/product.dart';
import 'package:prueba3_git/models/product_response.dart';
import 'package:prueba3_git/style/theme.dart' as Style;
//import 'package:prueba3_git/widgets/auditoria_datatable_widget.dart';
import 'package:prueba3_git/widgets/botones_busqueda_widget.dart';
import 'package:prueba3_git/widgets/botones_controlinventario_widget.dart';

class ControlInventarioScreen extends StatefulWidget {
  @override
  _ControlInventarioScreenState createState() =>
      _ControlInventarioScreenState();
}

class _ControlInventarioScreenState extends State<ControlInventarioScreen> {
  List<Product> lista;
  String hint = 'elast';

  @override
  void initState() {
    super.initState();
    productListBloc..getProductLista(hint);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductResponse>(
      stream: productListBloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
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

  Widget _buildHomeWidget(ProductResponse data) {
    lista = data.products;

    if (lista.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: Style.Colors.secondColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text('Control de inventario'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              BotonesBusquedaWidget(false),
              SizedBox(height: 30),
              //AuditoriaTablaWidget(),
              SizedBox(height: 80),
              Container(
                child: BotonesControlInventarioWidget(),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      );
  }
}

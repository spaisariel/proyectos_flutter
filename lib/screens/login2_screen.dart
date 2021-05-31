import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_branchOffice_bloc.dart';
import 'package:prueba3_git/main.dart';
import 'package:prueba3_git/models/branchOffice.dart';
import 'package:prueba3_git/models/branchOffice_response.dart';
import 'package:prueba3_git/models/user.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:prueba3_git/screens/maps_screen.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

// ignore: must_be_immutable
class Login2Screen extends StatefulWidget {
  User unUsuario;
  Login2Screen(this.unUsuario);
  @override
  _Login2ScreenState createState() => _Login2ScreenState(this.unUsuario);
}

class _Login2ScreenState extends State<Login2Screen> {
  User unUsuario;

  String nombreSucursal = '';
  String nombreDeposito = '';
  String idSucursal;
  String idDeposito;

  _Login2ScreenState(this.unUsuario);

  @override
  void initState() {
    super.initState();
    branchOfficeListBloc..getBranchOfficeLista(unUsuario.userInfo.id);
  }

  Widget build(BuildContext context) {
    return StreamBuilder<BranchOfficeResponse>(
      stream: branchOfficeListBloc.subject.stream,
      builder: (context, AsyncSnapshot<BranchOfficeResponse> snapshot) {
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

  Widget _buildHomeWidget(BranchOfficeResponse data) {
    BranchOffice unaSucursal = data.sucursales;
    return Scaffold(
      backgroundColor: Style.Colors.secondColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        child: Center(
          child: Column(
            children: [
              Container(
                child: new Image.asset(
                  'lib/assets/favicon.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sucursal ',
                    style: TextStyle(fontSize: 20),
                  ),
                  seleccionarSucursal(unaSucursal.name.toString(),
                      unaSucursal.branchOfficeId.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Deposito ',
                    style: TextStyle(fontSize: 20),
                  ),
                  seleccionarDeposito(unaSucursal.deposits)
                ],
              ),
              SizedBox(height: 15),
              selecionarComercio(),
              SizedBox(height: 100),
              ButtonTheme(
                minWidth: 200.0,
                child:
                    continuarButton(context, unUsuario, idSucursal, idDeposito),
              ),
              omitirButton(context, unUsuario),
            ],
          ),
        ),
      ),
    );
  }

  Widget seleccionarSucursal(String sucursal, String idSucursal) {
    String dropdownValue = sucursal;
    idSucursal = idSucursal;
    return StreamBuilder(builder: (context, snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 20),
        underline: Container(
          height: 2,
          color: Style.Colors.secondColor,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            nombreSucursal = newValue;
            this.idSucursal = idSucursal;
          });
        },
        items: <String>[sucursal.toString()]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }

  Widget seleccionarDeposito(List<Deposit> depositos) {
    String dropdownValue = depositos[0].name;
    idDeposito = depositos[0].depositId;
    List<String> nombreDepositos =
        depositos.map((deposito) => deposito.name).toList();
    return StreamBuilder(builder: (context, snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 20),
        underline: Container(
          height: 2,
          color: Style.Colors.secondColor,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            nombreDeposito = newValue;
            depositos.forEach((deposito) {
              if (deposito.name == newValue) {
                idDeposito = deposito.depositId;
              }
            });
          });
        },
        items: nombreDepositos.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}

Widget continuarButton(context, unUsuario, idSucursal, idDeposito) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.60,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Style.Colors.mainColor),
          //shape: MaterialStateProperty.all(botonRoundedRectangleBorder())),
          shape: MaterialStateProperty.all(
              Style.Shapes.botonGrandeRoundedRectangleBorder())),
      child: Text('Continuar',
          style: TextStyle(color: Colors.white, fontSize: 20)),
      onPressed: () {
        Repository()
            .guardarIdentificacionSucursalDeposito(idSucursal, idDeposito);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) =>
                PaginaInicial(unUsuario, idSucursal, idDeposito)));
      },
    ),
  );
}

Widget omitirButton(context, unUsuario) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.60,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Style.Colors.mainColor),
          shape: MaterialStateProperty.all(
              Style.Shapes.botonGrandeRoundedRectangleBorder())),
      child:
          Text('Omitir', style: TextStyle(color: Colors.white, fontSize: 20)),
      onPressed: () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => PaginaInicial(unUsuario, '2',
                '2'))); //EN UN FUTURO PONER UNA SUCURSAL Y DEPOSITO PREDETERMINADO
      },
    ),
  );
}

RoundedRectangleBorder botonRoundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(8.0),
    side: BorderSide(color: Style.Colors.mainColor),
  );
}

Widget selecionarComercio() {
  return StreamBuilder(
    builder: (context, snapshot) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.60,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Style.Colors.mainColor),
              shape: MaterialStateProperty.all(
                  Style.Shapes.botonGrandeRoundedRectangleBorder())),
          child: Text('Buscar en el mapa',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapaScreen(),
              ),
            );
          },
        ),
      );
    },
  );
}

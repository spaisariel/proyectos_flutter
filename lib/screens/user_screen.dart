import 'package:flutter/material.dart';
import 'package:prueba3_git/style/theme.dart' as Style;

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Perfil - Usuario Generico",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Casa Central",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 50),
                Text(
                  "Deposito 1",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),

            SizedBox(height: 50),

            ListTile(
              title: Row(
                children: [
                  Icon(Icons.mail),
                  Column(
                    children: [
                      Text("E-Mail",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text("mailgenerico@hotmail.com",
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),

            //SOLO A MODO DE PRUEBA, EN UN FUTURO QUEDARIA UN SOLO LIST LTILE
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.phone),
                  Column(
                    children: [
                      Text("Telefono",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text("+54 343 6200000",
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.place),
                  Column(
                    children: [
                      Text("Dirección",
                          style: TextStyle(color: Style.Colors.secondColor)),
                      Text("Siempre Viva 123",
                          style: TextStyle(color: Style.Colors.titleColor)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                  child: Text('Cambiar de sucursal o deposito',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),

            SizedBox(height: 25),

            ButtonTheme(
              buttonColor: Style.Colors.mainColor,
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Style.Colors.cancelColor,
                  onPressed: () {},
                  child: Text('Cerrar sesión',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ])),
    ));
  }
}

import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                  icon: Icon(Icons.filter_1),
                  onPressed: () {
                    // Do something
                  }),
              expandedHeight: 220.0,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 50,
              backgroundColor: Colors.pink,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    fit: BoxFit.cover,
                  )),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(_buildList(50))),
            ),
          ],
        ),
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    listItems.add(
      Text(
        'mailgenerico@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(
      Text(
        'fsg@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(
      Text(
        'jhgjnfmhfhmnf@hotmail.com',
        style: new TextStyle(fontSize: 25.0),
      ),
    );

    listItems.add(SizedBox(height: 25));

    listItems.add(RaisedButton(onPressed: null));

    return listItems;
  }
}

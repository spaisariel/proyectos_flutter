// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:prueba3_git/models/photo.dart';
// import 'package:prueba3_git/models/photo_response.dart';
// import 'package:prueba3_git/screens/auditoria_screen.dart';
// import '../screens/auditoria_screen.dart';

// class MenuScaffoldWidget extends StatefulWidget {
//   @override
//   _MenuScaffoldWidgetState createState() => _MenuScaffoldWidgetState();
// }

// class _MenuScaffoldWidgetState extends State<MenuScaffoldWidget> {
//   PageController pageController =
//       PageController(viewportFraction: 1, keepPage: true); //aaaa

//   @override
//   void initState() {
//     super.initState();
//     photoListBloc..getPhotoLista();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<PhotoResponse>(
//       stream: photoListBloc.subject.stream,
//       builder: (context, AsyncSnapshot<PhotoResponse> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data.error != null && snapshot.data.error.length > 0) {
//             return _buildErrorWidget(snapshot.data.error);
//           }
//           return _buildHomeWidget(snapshot.data);
//         } else if (snapshot.hasError) {
//           return _buildErrorWidget(snapshot.error);
//         } else {
//           return _buildLoadingWidget();
//         }
//       },
//     );
//   }

//   Widget _buildLoadingWidget() {
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 25.0,
//           width: 25.0,
//           child: CircularProgressIndicator(
//             valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
//             strokeWidth: 4.0,
//           ),
//         )
//       ],
//     ));
//   }

//   Widget _buildErrorWidget(String error) {
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Error occured: $error"),
//       ],
//     ));
//   }

//   Widget _buildHomeWidget(PhotoResponse data) {
//     List<Photo> albums = data.photos;
//     if (albums.length == 0) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Text(
//                   "No More Movies",
//                   style: TextStyle(color: Colors.black45),
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     } else
//       return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Container(
//             height: 150.0,
//             child: Card(
//               child: Container(
//                 child: ListTile(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
//                   trailing: Column(
//                     //mainAxisAlignment: MainAxisAlignment.center,
//                     //crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: IconButton(
//                             //iconSize: 50,
//                             icon: Icon(EvaIcons.edit),
//                             onPressed: () {}),
//                       ),
//                       Expanded(child: Text("Busqueda manual"))
//                     ],
//                   ),
//                   leading: Column(
//                     //mainAxisAlignment: MainAxisAlignment.center,
//                     //crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: IconButton(
//                             //iconSize: 50,
//                             icon: Icon(Icons.scanner),
//                             onPressed: () {}),
//                       ),
//                       Expanded(child: Text("QR"))
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//         Container(
//             height: 150.0,
//             child: Card(
//               child: Container(
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 10.0,
//                   ),
//                   title: Text(
//                     "Auditoria de gondola",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   subtitle:
//                       Text("Control de precios, stock y otros en gondola"),
//                   leading: Icon(
//                     EvaIcons.shoppingBag,
//                     size: 100,
//                   ),
//                 ),
//               ),
//             )),
//         Container(
//             height: 150.0,
//             child: Card(
//               child: Container(
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 10.0,
//                   ),
//                   title: Text(
//                     "Auditoria de gondola",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   subtitle:
//                       Text("Control de precios, stock y otros en gondola"),
//                   leading: Icon(
//                     EvaIcons.shoppingBag,
//                     size: 100,
//                   ),
//                 ),
//               ),
//             )),
//         Container(
//             height: 150.0,
//             child: Card(
//               child: Container(
//                 child: ListTile(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AuditoriaScreen(),
//                       ),
//                     );
//                   },
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 10.0,
//                   ),
//                   title: Text(
//                     "Auditoria de gondola",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   subtitle:
//                       Text("Control de precios, stock y otros en gondola"),
//                   leading: Icon(
//                     EvaIcons.shoppingBag,
//                     size: 100,
//                   ),
//                 ),
//               ),
//             )),
//       ]);
//   }
// }

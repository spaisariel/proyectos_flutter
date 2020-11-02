// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// CameraPosition _initialPosition =
//     CameraPosition(target: LatLng(26.8206, 30.8025));
// Completer<GoogleMapController> _controller = Completer();

// void _onMapCreated(GoogleMapController controller) {
//   _controller.complete(controller);
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Maps in Flutter'),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: <Widget>[
//             GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: _initialPosition,
//             ),
//           ],
//         ));
//   }
// }

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Set<Marker> _markers = HashSet<Marker>();
  //GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    //_mapController = controller;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(-31.742194, -60.525945),
            infoWindow:
                InfoWindow(title: "Casa Central", snippet: "Deposito 1")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mapa'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(-31.7331, -60.53),
            zoom: 12,
          ),
          markers: _markers,
        ));
  }
}

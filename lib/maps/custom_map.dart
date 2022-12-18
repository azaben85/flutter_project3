import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _MyAppState();
}

class _MyAppState extends State<CustomMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng _center = const LatLng(32.223994503129525, 35.229030065238476);
  int count = 0;
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        markers: markers,
        onTap: (LatLng x) {
          log(x.latitude.toString());
          log(x.longitude.toString());
          markers.add(Marker(markerId: MarkerId('id_$count'), position: x));
          count++;
          setState(() {});
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 20.0,
        ),
      ),
    );
  }
}

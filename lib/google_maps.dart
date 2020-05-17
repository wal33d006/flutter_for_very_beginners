import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}



class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();

  _addMarker() {
    final id = MarkerId('12');
    Marker marker = Marker(
      markerId: id,
      position: LatLng(37.43296265331129,-122.08832357078792),
      infoWindow: InfoWindow(title: 'Hello')
    );

    setState(() {
      markers[id] = marker;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 19.151926040649414,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}

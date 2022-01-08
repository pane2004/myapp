import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(43.65631782186271, -79.67912484606333),
          infoWindow: InfoWindow(
            title: "WM Mississauga Transfer Station",
            snippet: "6465 Danville Rd, Mississauga, ON L5T 2H7",
          )));
      _markers.add(const Marker(
          markerId: MarkerId('id-2'),
          position: LatLng(43.65631782186271, -79.67912484606333),
          infoWindow: InfoWindow(
            title: "Disposal Bins Mississauga",
            snippet: "1270 Central Pkwy W #404, Mississauga, ON L5C 4P4",
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Local Waste Depots"),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: const CameraPosition(
            target: LatLng(43.592337920450426, -79.61564521970341),
            zoom: 11,
          ),
        ));
  }
}

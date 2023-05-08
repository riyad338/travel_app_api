import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogeMapMarker extends StatefulWidget {
  const GoogeMapMarker({super.key});

  @override
  State<GoogeMapMarker> createState() => _GoogeMapMarkerState();
}

class _GoogeMapMarkerState extends State<GoogeMapMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(37.0000000, 122.000000), zoom: 14);
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(23.8103, 90.4125),
        infoWindow: InfoWindow(title: "title")),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(28.7041, 77.1025),
        infoWindow: InfoWindow(title: "t", snippet: "testing")),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(30.0000000, 122.000000),
        infoWindow: InfoWindow(title: "r")),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
    );
  }
}

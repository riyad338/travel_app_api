import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/hotel_model.dart';
import 'package:travel_app/models/resturant_model.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/providers/resturant_provider.dart';
import 'package:travel_app/screens/location_permission.dart';

class CurrentLocation extends StatefulWidget {
  CurrentLocation({Key? key, this.lat, this.lon})
      : super(
          key: key,
        );
  double? lat;
  double? lon;

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.42796133580664, 90.085749655962), zoom: 10);
  List<Marker> _marker = [];
  List<Marker> _list = [];

  @override
  void didChangeDependencies() {
    _marker.addAll(_list);

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700.h,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GoogleMap(
                  scrollGesturesEnabled: true,
                  buildingsEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse("${widget.lat}"),
                          double.parse("${widget.lon}")),
                      zoom: 12),
                  markers: Set<Marker>.of([
                    Marker(
                        icon: BitmapDescriptor.defaultMarker,
                        markerId: MarkerId("Current Location"),
                        infoWindow: InfoWindow(title: " Current Location"),
                        position: LatLng(double.parse("${widget.lat}"),
                            double.parse("${widget.lon}")))
                  ]),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      _controller.complete(controller);
                    });
                  }),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/location_permission.dart';

class AllLocation extends StatefulWidget {
  const AllLocation({Key? key}) : super(key: key);

  @override
  State<AllLocation> createState() => _AllLocationState();
}

class _AllLocationState extends State<AllLocation> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(23.42796133580664, 90.085749655962), zoom: 14);
  List<Marker> _marker = [];
  List<Marker> _list = [];
  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700.h,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: 500.h,
                    width: double.infinity,
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      initialCameraPosition: initialCameraPosition,
                      markers: Set<Marker>.of(_marker),
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        googleMapController = controller;
                      },
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 10.h,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    // Position position = await determinePosition();
                    // setState(() {});
                    // googleMapController.animateCamera(
                    //     CameraUpdate.newCameraPosition(CameraPosition(
                    //         target:
                    //             LatLng(position.latitude, position.longitude),
                    //         zoom: 14)));
                    //
                    // setState(() {});
                    // markers.add(Marker(
                    //     markerId: const MarkerId('currentLocation'),
                    //     position:
                    //         LatLng(position.latitude, position.longitude)));
                  },
                  child: Text("Use Location"),
                ),
              ),
            )
          ],
        ));
  }
}

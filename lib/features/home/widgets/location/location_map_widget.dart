import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/location_controller.dart';

class LocationMapWidget extends StatelessWidget {
  final LocationController controller;

  const LocationMapWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: controller.defaultLocation,
        zoom: 16,
        tilt: 60.0,
        bearing: 0.0,
      ),
      onMapCreated: controller.setMapController,
      onTap: controller.onMapTapped,
      markers: controller.markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: true,
      mapType: MapType.normal,
      buildingsEnabled: true,
      trafficEnabled: false,
      fortyFiveDegreeImageryEnabled: true,
    );
  }
}

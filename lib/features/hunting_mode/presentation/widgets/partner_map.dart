import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PartnerMap extends StatelessWidget {
  final Position position;

  const PartnerMap({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final LatLng userLatLng = LatLng(position.latitude, position.longitude);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: userLatLng,
        zoom: 14,
      ),
      markers: {
        Marker(markerId: const MarkerId("user"), position: userLatLng),
        // لاحقًا نضيف شركاء كـ markers
      },
      myLocationEnabled: true,
    );
  }
}

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GelocatorHelpr {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If services are disabled, open the location settings
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled. Please enable them in your device settings.');
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied. Please grant location access.');
      }
    }

    // If the permission is denied forever
    if (permission == LocationPermission.deniedForever) {
      // Optionally, prompt the user to open app settings
      await Geolocator.openAppSettings();
      throw Exception('Location permissions are permanently denied. You need to enable them from settings.');
    }

    // Get the current position of the user
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

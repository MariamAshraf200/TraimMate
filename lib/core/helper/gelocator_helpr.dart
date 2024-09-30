import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GelocatorHelpr {
  Future<String> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled. Please enable them in your device settings.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied. Please grant location access.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied. You need to enable them from settings.';
    }

    // Get the current position of the user.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      // Reverse geocoding to convert the coordinates to a human-readable address.
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Get the first placemark from the list
      Placemark place = placemarks[0];

      // Return the formatted address (city and country)
      return '${place.locality}, ${place.country}';
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        return 'Geocoding service is unavailable. Please try again later.';
      } else {
        return 'Failed to get location: ${e.message}';
      }
    } catch (e) {
      print('$e');
      return 'Failed to get location: $e';
    }
  }
}

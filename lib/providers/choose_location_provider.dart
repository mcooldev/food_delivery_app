import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ChooseLocationProvider with ChangeNotifier {
  /// List of locations
  final List<String> _locationList = [
    "Parcelles Assainies, Unité 24",
    "HLM Grand Yoff, dibiterie Koromack Faye",
    "Ouest Foire, Tally Nak",
    "Yoff Océan",
    "Pikine Icotaf",
    "Guédiawaye, Sahm",
    "Petit, 2e porte",
    "Keur Massar, Almadies 2",
  ];

  List<String> get locationList => [..._locationList];

  ///
  int selectedLocationIndex = -1;

  String? currentLocation;

  void selectLocation(BuildContext context, int index) {
    selectedLocationIndex = index;
    notifyListeners();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  /// Get address
  String getAddress() {
    /// Return current location if not null
    if (currentLocation != null && currentLocation!.isNotEmpty) {
      return currentLocation!;
    }

    /// Return selected location if not null
    if (selectedLocationIndex >= 0 &&
        selectedLocationIndex < _locationList.length) {
      return _locationList[selectedLocationIndex];
    }
    return "Choissez une adresse";
  }

  /// Fetch current location
  Future<void> fetchCurrentLocation() async {
    try {
      final fetchedLocation = await getCurrentLocation();
      if (fetchedLocation != null && fetchedLocation.isNotEmpty) {
        currentLocation = fetchedLocation;
        notifyListeners();
      }
    } catch (e) {
      log("Erreur lors de la récupération de la position actuelle: ${e.toString()}");
    }
  }

  ///
  Future<String?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      currentLocation = "${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}";
    }
    return currentLocation ?? '';
  }
}

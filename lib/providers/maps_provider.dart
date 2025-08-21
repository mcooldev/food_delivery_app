import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_delivery_app/constants/google_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsProvider with ChangeNotifier {
  /// controllers
  GoogleMapController? googleMapController;

  /// onMapCreated
  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();
  }

  /// Source and destination
  static final LatLng _sourceLocation = const LatLng(48.8566, 2.3522);

  LatLng get sourceLocation => _sourceLocation;
  static final LatLng _destinationLocation = const LatLng(49.2583, 4.0317);

  LatLng get destinationLocation => _destinationLocation;


  /// Get polyline points function
    final List<LatLng> _polylineCoordinates = [];
    List<LatLng> get polylineCoordinates => [..._polylineCoordinates];
  Future<List<LatLng>> getPolyline() async {
    ///
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey2,
      request: PolylineRequest(
        origin: PointLatLng(
          _sourceLocation.latitude,
          _sourceLocation.longitude,
        ),
        destination: PointLatLng(
          _destinationLocation.latitude,
          _destinationLocation.longitude,
        ),
        mode: TravelMode.driving,
      ),
    );

    ///
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      notifyListeners();
    }

    return _polylineCoordinates;
  }

  /// Animate camera to position method helper
  Future<void> animateToPosition(LatLng position, double zoom) async {
    if (googleMapController != null) {
      await googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: zoom),
        ),
      );
    } else {
      throw Exception("Map controller not initialized");
    }
  }

  /// Get current position
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    /// Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    /// Permissions are denied forever, handle appropriately.
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  /// Disposer
  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController = null;
    super.dispose();
  }
}

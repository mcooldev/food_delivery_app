import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/providers/maps_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  /// initState function for initializing methods

  Future<void> initializeMap() async {
    final map = context.read<MapsProvider>();
    try {
      Position initialPosition = await map.getPosition();
      await map.animateToPosition(
        LatLng(initialPosition.latitude, initialPosition.longitude),
        14.0,
      );
    } catch (e) {
      log("error getting location: ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();

    /// Initializing map location
    // WidgetsBinding.instance.addPostFrameCallback((_) => initializeMap());

    /// Get polyline method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<MapsProvider>().getPolyline();
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      /*App bar content here*/
      appBar: AppBar(title: const Text("Google maps"), backgroundColor: white),

      /*Floating action button content here*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        onPressed: () async {
          final maps = context.read<MapsProvider>();
          try {
            ///
            Position position = await maps.getPosition();

            /// Animate camera position
            await maps.animateToPosition(
              LatLng(position.latitude, position.longitude),
              14.0,
            );
          } catch (e) {
            log("Error getting location: ${e.toString()}");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        child: Icon(Icons.my_location_rounded, color: white),
      ),

      /* Body content here */
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<MapsProvider>(
              builder: (_, maps, _) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  height: 600,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(width: 1, color: white)
                    ),
                    shadows: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        blurRadius: 30,
                        spreadRadius: 3,
                        color: lightBg
                      )
                    ],
                  ),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: maps.sourceLocation,
                      zoom: 8.0,
                    ),
                    onMapCreated: (controller) {
                      maps.onMapCreated(controller);
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: maps.polylineCoordinates,
                        width: 5,
                        color: purple,
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("source"),
                        position: maps.sourceLocation,
                        infoWindow: const InfoWindow(title: "Source")
                      ),
                      Marker(
                        markerId: const MarkerId("destination"),
                        position: maps.destinationLocation,
                        infoWindow: const InfoWindow(title: "Destination")
                      ),
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

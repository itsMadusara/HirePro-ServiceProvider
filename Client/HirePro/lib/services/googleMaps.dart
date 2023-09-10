import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  late Marker sourceMarker;
  late Marker destinationMarker;
  late Position _currentPosition;

  static LatLng sourceLocation = LatLng(6.8943, 79.8685);
  static const LatLng destinationLocation = LatLng(6.8940, 79.8547);

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  late LatLngBounds _bounds;


  // getLocationUpdates() {
  //   final LocationSettings locationSettings =
  //   LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 0);
  //
  //   StreamSubscription<ServiceStatus> serviceStatusStream =
  //   Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
  //     sourceLocation = status as LatLng;
  //     print(status);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    drawPolyline();
    // getLocationUpdates();
    // _calculateBounds();
  }

  void drawPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {});
    }
  }

  // void _calculateBounds() {
  //   double minLat = sourceLocation.latitude;
  //   double maxLat = destinationLocation.latitude;
  //   double minLng = sourceLocation.longitude;
  //   double maxLng = destinationLocation.longitude;
  //
  //   // Update the bounds
  //   _bounds = LatLngBounds(
  //     southwest: LatLng(minLat, minLng),
  //     northeast: LatLng(maxLat, maxLng),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(6.8943, 79.8685),
          zoom: 13.5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: <Marker>[
          Marker(
            markerId: MarkerId('sourcePin'),
            position: sourceLocation,
            icon: BitmapDescriptor.defaultMarker,
          ),
          Marker(
            markerId: MarkerId('destinationPin'),
            position: destinationLocation,
            icon: BitmapDescriptor.defaultMarker,
          ),
        ].toSet(),
        polylines: <Polyline>[
          Polyline(
            polylineId: PolylineId('polyline'),
            color: Colors.blue,
            points: polylineCoordinates,
            width: 5,
          ),
        ].toSet(),
      ),
    );
  }
}
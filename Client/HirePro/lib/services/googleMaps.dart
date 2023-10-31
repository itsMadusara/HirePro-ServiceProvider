import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleMaps extends StatefulWidget {
  Map<String,dynamic> taskDescription;
  GoogleMaps({required this.taskDescription});
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  late Marker sourceMarker;
  late Marker destinationMarker;
  late Position _currentPosition;
  late StreamSubscription<Position> _positionStream;
  late String duration = "";
  late double distance = 0;

  static LatLng sourceLocation = LatLng(0.0, 0.0);
  static LatLng destinationLocation = LatLng(6.8940, 79.8547);

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void setDestination(){
    destinationLocation = LatLng(double.parse(widget.taskDescription['serviceValue']['latitude']), double.parse(widget.taskDescription['serviceValue']['longitude']));
  }

  Future<String> updateLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('updateLocation')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
        body: jsonEncode({"serviceid" : widget.taskDescription['serviceValue']['id'], "longitude" : sourceLocation.longitude, "latitude" : sourceLocation.latitude})
    );
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        updateLocation();
      }
      throw Exception('Failed to load album');
    }
  }

  Future<void> getCurrentPosition() async {
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position,);
      sourceLocation = LatLng(_currentPosition.latitude.toDouble(), _currentPosition.longitude.toDouble());
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _initializeMap() async {
    await getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _initializeMap();
    setDestination();

    const locationUpdateInterval = Duration(seconds: 10);
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        _currentPosition = position;
        sourceLocation = LatLng(position.latitude, position.longitude);
      });
      updateLocation();
      drawPolyline();
      fetchStats();
    });

  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }


  void drawPolyline() async {

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    polylineCoordinates.clear();
    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  Future<void> fetchStats() async {
    final slat = sourceLocation.latitude;
    final slon = sourceLocation.longitude;
    final dlat = destinationLocation.latitude;
    final dlon = destinationLocation.longitude;
    final apiKey = "AIzaSyDNOO9bzzNn34HNXZY1xT5IVvOlV37zFuE";

    final url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$slat,$slon&destinations=$dlat,$dlon&units=imperial&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final durationText = data["rows"][0]["elements"][0]["duration"]["text"];
      final distanceText = data["rows"][0]["elements"][0]["distance"]["text"];
      setState(() {
        duration = durationText;
        final double distanceMiles = double.parse(distanceText.replaceAll(" mi", ""));
        distance = distanceMiles * 1.60934;
      });
    } else {
      setState(() {
        duration = "Error: ${response.statusCode}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Arriving in : " + duration, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  SizedBox(height: 5,),
                  Text("Distance " + distance.toStringAsFixed(3) + " KM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            Container(
              height: 400,
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
                    icon: BitmapDescriptor.defaultMarkerWithHue(120),
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
            )
          ],
        )
    );
  }
}
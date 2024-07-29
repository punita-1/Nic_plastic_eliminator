import 'dart:async';
import 'dart:convert'; // for jsonDecode
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http; // for making HTTP requests

const String GOOGLE_MAP_API_KEY =
    "AIzaSyDS753o8uxyrBe5ydEccrgcjRuBNep455o"; // Your API key

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Define the locations with LatLng
  static const LatLng _PGooglePlex =
      LatLng(29.96864786713018, 76.82377581647059);
  static const LatLng _PApplePlex = LatLng(29.977113574637, 76.90041187653861);
  static const LatLng _PThirdLocation =
      LatLng(29.95739957137656, 76.81749471740069);

  LatLng? _currentP;
  Location _locationController = Location();
  Map<PolylineId, Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(child: Text('Loading...'))
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) =>
                  _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: _PGooglePlex,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                  onTap: () {
                    _onMarkerTapped(_currentP!);
                  },
                ),
                Marker(
                  markerId: MarkerId("PGooglePlex"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _PGooglePlex,
                  onTap: () {
                    _onMarkerTapped(_PGooglePlex);
                  },
                ),
                Marker(
                  markerId: MarkerId("PApplePlex"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _PApplePlex,
                  onTap: () {
                    _onMarkerTapped(_PApplePlex);
                  },
                ),
                Marker(
                  markerId: MarkerId("PThirdLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _PThirdLocation,
                  onTap: () {
                    _onMarkerTapped(_PThirdLocation);
                  },
                ),
              },
              polylines: Set<Polyline>.of(_polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<void> _onMarkerTapped(LatLng destination) async {
    if (_currentP != null) {
      List<LatLng> polylineCoordinates =
          await _getPolylinePoints(_currentP!, destination);
      if (polylineCoordinates.isNotEmpty) {
        _setPolylines(polylineCoordinates);
        _cameraToPosition(destination);
      } else {
        // Handle the case where no polyline is returned
        print('No route found or error in fetching route.');
      }
    }
  }

  Future<List<LatLng>> _getPolylinePoints(
      LatLng origin, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    final String url = 'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&key=$GOOGLE_MAP_API_KEY';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final route = data['routes'][0]['overview_polyline']['points'];
          final List<LatLng> decodedPoints = _decodePoly(route);
          polylineCoordinates.addAll(decodedPoints);
        } else {
          print('Error: ${data['status']}');
        }
      } else {
        print('Failed to load directions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching directions: $e');
    }
    return polylineCoordinates;
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;
    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = LatLng((lat / 1E5), (lng / 1E5));
      poly.add(p);
    }
    return poly;
  }

  void _setPolylines(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("route");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      _polylines[id] = polyline;
    });
  }
}

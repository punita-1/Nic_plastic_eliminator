// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert'; // For jsonDecode
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:plastic_eliminator/core/constants.dart'; // Importing configuration file

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Define fixed locations with LatLng
  static const LatLng _pGooglePlex =
      LatLng(29.96864786713018, 76.82377581647059);
  static const LatLng _pApplePlex = LatLng(29.977113574637, 76.90041187653861);
  static const LatLng _pThirdLocation =
      LatLng(29.95739957137656, 76.81749471740069);

  LatLng? _currentPosition;
  final Location _locationService = Location();
  final Map<PolylineId, Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Plastic Drop Off Near You',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: _currentPosition == null
          ? const Center(child: Text('Loading...'))
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) =>
                  _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: _pGooglePlex,
                zoom: 13,
              ),
              markers: _buildMarkers(),
              polylines: Set<Polyline>.of(_polylines.values),
            ),
    );
  }

  // Creates markers for predefined locations
  Set<Marker> _buildMarkers() {
    return {
      // Marker(
      //   markerId: MarkerId("currentLocation"),
      //   icon: BitmapDescriptor.defaultMarker,
      //   position: _currentPosition!,
      //   onTap: () {
      //     _onMarkerTapped(_currentPosition!);
      //   },
      // ),
Marker(
  markerId: const MarkerId("currentLocation"),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Change to blue color
  position: _currentPosition!,
  onTap: () {
    _onMarkerTapped(_currentPosition!);
  },
),


      Marker(
        markerId: MarkerId("pGooglePlex"),
        icon: BitmapDescriptor.defaultMarker,
        position: _pGooglePlex,
        onTap: () {
          _onMarkerTapped(_pGooglePlex);
        },
      ),
      Marker(
        markerId: MarkerId("pApplePlex"),
        icon: BitmapDescriptor.defaultMarker,
        position: _pApplePlex,
        onTap: () {
          _onMarkerTapped(_pApplePlex);
        },
      ),
      Marker(
        markerId: MarkerId("pThirdLocation"),
        icon: BitmapDescriptor.defaultMarker,
        position: _pThirdLocation,
        onTap: () {
          _onMarkerTapped(_pThirdLocation);
        },
      ),
    };
  }

  // Moves the camera to the specified position
  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    final CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  // Listens for location updates and updates the map accordingly
  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationService.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentPosition!);
        });
      }
    });
  }

  // Handles marker tap to display route
  Future<void> _onMarkerTapped(LatLng destination) async {
    if (_currentPosition != null) {
      final List<LatLng> polylineCoordinates = await _getPolylinePoints(_currentPosition!, destination);
      if (polylineCoordinates.isNotEmpty) {
        _setPolylines(polylineCoordinates);
        _cameraToPosition(destination);
      } else {
        // print('No route found or error in fetching route.');
      }
    }
  }

  // Fetches polyline points from Google Directions API
  Future<List<LatLng>> _getPolylinePoints(LatLng origin, LatLng destination) async {
    final List<LatLng> polylineCoordinates = [];
    final String url = 'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&key=${Config.googleMapApiKey}'; // Use API key from config

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final route = data['routes'][0]['overview_polyline']['points'];
          final List<LatLng> decodedPoints = _decodePoly(route);
          polylineCoordinates.addAll(decodedPoints);
        } else {
          // print('Error: ${data['status']}');
        }
      } else {
        // print('Failed to load directions: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching directions: $e');
    }
    return polylineCoordinates;
  }

  // Decodes the polyline points from encoded string
  List<LatLng> _decodePoly(String encoded) {
    final List<LatLng> poly = [];
    int index = 0;
    final int len = encoded.length;
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
      final int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      final LatLng p = LatLng((lat / 1E5), (lng / 1E5));
      poly.add(p);
    }
    return poly;
  }

  // Sets polyline on the map
  void _setPolylines(List<LatLng> polylineCoordinates) {
    final PolylineId id = PolylineId("route");
    final Polyline polyline = Polyline(
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  late Marker _currentMarker;
  late Marker _destinationMarker;
  final Set<Marker> _markers = {};
  String _errorMessage = '';

  // Destination Location
  final LatLng _destinationLatLng = const LatLng(28.5355, 77.3910);

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
  }

  // Check and Request Permissions
  Future<void> _checkPermissionsAndGetLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = "Location services are disabled. Please enable them.";
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage =
            "Location permission denied. Please grant permission.";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage =
          "Location permission permanently denied. Please enable it in settings.";
        });
        return;
      }

      // If permission granted, get current location
      _getCurrentLocation();
    } catch (e) {
      setState(() {
        _errorMessage = "Error checking location permissions: $e";
      });
    }
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _currentMarker = Marker(
          markerId: const MarkerId('current_marker'),
          position:
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(title: "Current Location"),
        );

        _destinationMarker = Marker(
          markerId: const MarkerId('destination_marker'),
          position: _destinationLatLng,
          infoWindow: const InfoWindow(title: "Destination"),
        );

        _markers.add(_currentMarker);
        _markers.add(_destinationMarker);
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching location: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Track Order')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = '';
                  });
                  _checkPermissionsAndGetLocation();
                },
                child: const Text('Grant Permission'),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentPosition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 14.0, // Set a zoom level for better view
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true,  // Enable showing the current location on map
        myLocationButtonEnabled: true,  // Enable the location button
      ),
    );
  }
}

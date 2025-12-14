import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends ChangeNotifier {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  String _currentAddress = 'Fetching location...';
  bool _isLoading = true;
  Set<Marker> _markers = {};
  
  // Default location (Dhaka, Bangladesh)
  static const LatLng _defaultLocation = LatLng(23.8103, 90.4125);
  LatLng _selectedLocation = _defaultLocation;

  // Getters
  GoogleMapController? get mapController => _mapController;
  Position? get currentPosition => _currentPosition;
  String get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  Set<Marker> get markers => _markers;
  LatLng get selectedLocation => _selectedLocation;
  LatLng get defaultLocation => _defaultLocation;

  // Initialize location services
  Future<void> initializeLocation() async {
    await _requestLocationPermission();
  }

  // Request location permission
  Future<void> _requestLocationPermission() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _currentAddress = 'Location services are disabled';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _currentAddress = 'Location permission denied';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _currentAddress = 'Location permission permanently denied';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // If permission granted, get current location
      await getCurrentLocation();
    } catch (e) {
      _currentAddress = 'Error requesting permission: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _currentAddress = 'Location services are disabled. Using default location.';
        _isLoading = false;
        notifyListeners();
        _addDefaultLocationMarker();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _currentAddress = 'Location permission denied. Using default location.';
          _isLoading = false;
          notifyListeners();
          _addDefaultLocationMarker();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _currentAddress = 'Location permission permanently denied. Using default location.';
        _isLoading = false;
        notifyListeners();
        _addDefaultLocationMarker();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );

      _currentPosition = position;
      _selectedLocation = LatLng(position.latitude, position.longitude);

      // Get address from coordinates
      await _getAddressFromLatLng(position.latitude, position.longitude);

      // Add marker and move camera with enhanced 3D animation
      _addMarker(_selectedLocation);
      if (_mapController != null) {
        await _animateToLocation(_selectedLocation, 18.0, 60.0);
      }
    } catch (e) {
      String errorMessage = 'Unknown error';
      if (e.toString().contains('Location services are disabled')) {
        errorMessage = 'Please enable location services in your device settings';
      } else if (e.toString().contains('Location permission denied')) {
        errorMessage = 'Location permission denied. Please grant permission in settings';
      } else if (e.toString().contains('Location permission permanently denied')) {
        errorMessage = 'Location permission permanently denied. Please enable in app settings';
      } else if (e.toString().contains('Network')) {
        errorMessage = 'Network error. Please check your internet connection';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Location request timed out. Using default location';
      } else {
        errorMessage = 'Error: ${e.toString()}';
      }
      
      _currentAddress = '$errorMessage. Using default location.';
      _isLoading = false;
      notifyListeners();
      
      // Add default location marker as fallback
      _addDefaultLocationMarker();
    }
  }

  // Add default location marker as fallback
  void _addDefaultLocationMarker() {
    _addMarker(_defaultLocation);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_defaultLocation, 12),
    );
    _currentAddress = 'Dhaka, Bangladesh (Default Location)';
    notifyListeners();
  }

  // Get address from coordinates
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _currentAddress = 'Could not get address';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add marker on map
  void _addMarker(LatLng position) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected_location'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: _currentAddress,
        ),
      ),
    );
    notifyListeners();
  }

  // Handle map tap with enhanced 3D animation
  void onMapTapped(LatLng position) {
    _selectedLocation = position;
    _isLoading = true;
    notifyListeners();
    _addMarker(position);
    _getAddressFromLatLng(position.latitude, position.longitude);
    _animateToLocation(position, 16.0, 60.0);
  }

  // Enhanced camera animation
  Future<void> _animateToLocation(LatLng target, double zoom, double tilt) async {
    if (_mapController == null) return;
    
    try {
      // Create smooth multi-step animation
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: target,
            zoom: zoom - 2,
            tilt: 0.0,
            bearing: 0.0,
          ),
        ),
      );
      
      // Wait a bit then zoom in with tilt
      await Future.delayed(const Duration(milliseconds: 200));
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: target,
            zoom: zoom,
            tilt: tilt,
            bearing: 0.0,
          ),
        ),
      );
    } catch (e) {
      // Fallback to simple animation
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(target, zoom),
      );
    }
  }

  // Enhanced zoom controls with smooth animations
  Future<void> zoomIn() async {
    if (_mapController == null) return;
    await _mapController!.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> zoomOut() async {
    if (_mapController == null) return;
    await _mapController!.animateCamera(CameraUpdate.zoomOut());
  }

  // Apply dark theme styling to map
  void applyMapStyle() {
    if (_mapController == null) return;
    
    const String mapStyle = '''
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#000000"
          }
        ]
      },
      {
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#000000"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1C1C1E"
          }
        ]
      },
      {
        "featureType": "administrative.country",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "administrative.locality",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "featureType": "administrative.neighborhood",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1C1C1E"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1C1C1E"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2C2C2E"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#000000"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2C2C2E"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2C2C2E"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#3A3A3C"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1C1C1E"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#0A0A0A"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#FFFFFF"
          }
        ]
      }
    ]
    ''';
    
    _mapController!.setMapStyle(mapStyle);
  }

  // Search location
  Future<void> searchLocation(String query) async {
    if (query.trim().isEmpty) {
      throw Exception('Please enter a location to search');
    }
    
    try {
      _isLoading = true;
      notifyListeners();
      
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newLocation = LatLng(
          location.latitude,
          location.longitude,
        );
        _selectedLocation = newLocation;
        _addMarker(newLocation);
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newLocation,
              zoom: 15,
              tilt: 60.0,
              bearing: 0.0,
            ),
          ),
        );
        await _getAddressFromLatLng(
          location.latitude,
          location.longitude,
        );
      } else {
        throw Exception('No results found for: $query');
      }
    } catch (e) {
      String errorMessage = 'Unknown error occurred';
      
      if (e.toString().contains('no results')) {
        errorMessage = 'No results found for: $query';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your internet connection';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Request timed out. Please try again';
      } else if (e.toString().contains('API')) {
        errorMessage = 'Geocoding service unavailable. Please try again later';
      } else {
        errorMessage = 'Location not found: $query';
      }
      
      throw Exception(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set map controller
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    // Automatically get current location when map is ready
    getCurrentLocation();
  }

  // Get error message for snackbar
  String getErrorMessage() {
    if (_currentAddress.contains('Error:') || 
        _currentAddress.contains('disabled') ||
        _currentAddress.contains('denied') ||
        _currentAddress.contains('timeout') ||
        _currentAddress.contains('Network')) {
      return _currentAddress.split('.')[0]; // Return first part before "Using default location"
    }
    return '';
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

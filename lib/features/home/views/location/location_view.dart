import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class LocationViewPage extends StatefulWidget {
  const LocationViewPage({super.key});

  @override
  State<LocationViewPage> createState() => _LocationViewPageState();
}

class _LocationViewPageState extends State<LocationViewPage> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  String _currentAddress = 'Fetching location...';
  bool _isLoading = true;
  Set<Marker> _markers = {};
  
  // Default location (Dhaka, Bangladesh)
  static const LatLng _defaultLocation = LatLng(23.8103, 90.4125);
  LatLng _selectedLocation = _defaultLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // Request location permission
  Future<void> _requestLocationPermission() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentAddress = 'Location services are disabled';
          _isLoading = false;
        });
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentAddress = 'Location permission denied';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentAddress = 'Location permission permanently denied';
          _isLoading = false;
        });
        return;
      }

      // If permission granted, get current location
      _getCurrentLocation();
    } catch (e) {
      setState(() {
        _currentAddress = 'Error requesting permission: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentAddress = 'Location services are disabled. Using default location.';
          _isLoading = false;
        });
        _addDefaultLocationMarker();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentAddress = 'Location permission denied. Using default location.';
            _isLoading = false;
          });
          _addDefaultLocationMarker();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentAddress = 'Location permission permanently denied. Using default location.';
          _isLoading = false;
        });
        _addDefaultLocationMarker();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );

      setState(() {
        _currentPosition = position;
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });

      // Get address from coordinates
      await _getAddressFromLatLng(position.latitude, position.longitude);

      // Add marker and move camera
      _addMarker(_selectedLocation);
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedLocation, 15),
      );
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
      
      setState(() {
        _currentAddress = '$errorMessage. Using default location.';
        _isLoading = false;
      });
      
      // Add default location marker as fallback
      _addDefaultLocationMarker();
      
      // Show error in snackbar for better visibility
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Add default location marker as fallback
  void _addDefaultLocationMarker() {
    _addMarker(_defaultLocation);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_defaultLocation, 12),
    );
    setState(() {
      _currentAddress = 'Dhaka, Bangladesh (Default Location)';
    });
  }

  // Get address from coordinates
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = 'Could not get address';
        _isLoading = false;
      });
    }
  }

  // Add marker on map
  void _addMarker(LatLng position) {
    setState(() {
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
    });
  }

  // Handle map tap
  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _isLoading = true;
    });
    _addMarker(position);
    _getAddressFromLatLng(position.latitude, position.longitude);
  }

  // Search location (you can implement search functionality here)
  void _searchLocation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildSearchSheet(),
    );
  }

  Widget _buildSearchSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search location...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) async {
              // Implement search functionality
              try {
                List<Location> locations = await locationFromAddress(value);
                if (locations.isNotEmpty) {
                  Location location = locations.first;
                  LatLng newLocation = LatLng(
                    location.latitude,
                    location.longitude,
                  );
                  setState(() {
                    _selectedLocation = newLocation;
                  });
                  _addMarker(newLocation);
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(newLocation, 15),
                  );
                  _getAddressFromLatLng(
                    location.latitude,
                    location.longitude,
                  );
                  Navigator.pop(context);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location not found: $value')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defaultLocation,
              zoom: 12,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: _onMapTapped,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: true,
            mapType: MapType.normal,
          ),

          // Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Back Button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title
                    const Expanded(
                      child: Text(
                        'Your Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Search Button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: _searchLocation,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Info Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5E7CE2).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Color(0xFF5E7CE2),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selected Location',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF5E7CE2),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      _currentAddress,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _getCurrentLocation,
                            icon: const Icon(Icons.my_location),
                            label: const Text('Current Location'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5E7CE2),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Return selected location
                            Navigator.pop(context, {
                              'address': _currentAddress,
                              'latitude': _selectedLocation.latitude,
                              'longitude': _selectedLocation.longitude,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4DB8AC),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Zoom Controls
          Positioned(
            right: 16,
            bottom: 200,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      _mapController?.animateCamera(CameraUpdate.zoomIn());
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      _mapController?.animateCamera(CameraUpdate.zoomOut());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
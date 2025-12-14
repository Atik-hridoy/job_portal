import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/location_controller.dart';
import '../../widgets/location/location_map_widget.dart';
import '../../widgets/location/location_app_bar_widget.dart';
import '../../widgets/location/location_info_widget.dart';
import '../../widgets/location/zoom_controls_widget.dart';
import '../../widgets/location/location_search_sheet_widget.dart';

class LocationViewPage extends StatefulWidget {
  const LocationViewPage({super.key});

  @override
  State<LocationViewPage> createState() => _LocationViewPageState();
}

class _LocationViewPageState extends State<LocationViewPage> {
  late LocationController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = LocationController();
    _locationController.initializeLocation();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LocationSearchSheetWidget(
        onLocationSearched: _locationController.searchLocation,
      ),
    );
  }

  void _handleError() {
    final errorMessage = _locationController.getErrorMessage();
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _locationController,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        body: Stack(
          children: [
            // Google Map
            LocationMapWidget(controller: _locationController),

            // Top App Bar
            LocationAppBarWidget(
              onBackPressed: () => Navigator.pop(context),
              onSearchPressed: _showSearchSheet,
            ),

            // Bottom Info Card
            Consumer<LocationController>(
              builder: (context, controller, child) {
                // Show error snackbar if needed
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _handleError();
                });

                return LocationInfoWidget(
                  currentAddress: controller.currentAddress,
                  isLoading: controller.isLoading,
                  onCurrentLocationPressed: controller.getCurrentLocation,
                  onConfirmPressed: () {
                    Navigator.pop(context, {
                      'address': controller.currentAddress,
                      'latitude': controller.selectedLocation.latitude,
                      'longitude': controller.selectedLocation.longitude,
                    });
                  },
                );
              },
            ),

            // Zoom Controls
            ZoomControlsWidget(
              onZoomInPressed: _locationController.zoomIn,
              onZoomOutPressed: _locationController.zoomOut,
            ),
          ],
        ),
      ),
    );
  }
}
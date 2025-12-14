import 'package:flutter/material.dart';

class ZoomControlsWidget extends StatelessWidget {
  final VoidCallback onZoomInPressed;
  final VoidCallback onZoomOutPressed;

  const ZoomControlsWidget({
    super.key,
    required this.onZoomInPressed,
    required this.onZoomOutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              onPressed: onZoomInPressed,
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
              onPressed: onZoomOutPressed,
            ),
          ),
        ],
      ),
    );
  }
}

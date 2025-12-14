import 'package:flutter/material.dart';

class LocationSearchSheetWidget extends StatefulWidget {
  final Function(String) onLocationSearched;

  const LocationSearchSheetWidget({
    super.key,
    required this.onLocationSearched,
  });

  @override
  State<LocationSearchSheetWidget> createState() => _LocationSearchSheetWidgetState();
}

class _LocationSearchSheetWidgetState extends State<LocationSearchSheetWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search location...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: _isSearching 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : const Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabled: !_isSearching,
            ),
            onSubmitted: (value) async {
              if (value.isNotEmpty && !_isSearching) {
                setState(() {
                  _isSearching = true;
                });
                
                try {
                  await widget.onLocationSearched(value);
                  if (mounted) Navigator.pop(context);
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString().replaceFirst('Exception: ', '')),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isSearching = false;
                    });
                  }
                }
              }
            },
          ),
          if (_isSearching) ...[
            const SizedBox(height: 16),
            const Text(
              'Searching location...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            'Try: "Dhaka", "New York", "London", or a specific address',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

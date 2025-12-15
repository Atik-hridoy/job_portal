import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../views/edit_profile_view.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel _profile = ProfileModel.defaultProfile();
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  ProfileModel get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Initialize with profile data
  void initializeProfile(ProfileModel? profile) {
    if (profile != null) {
      _profile = profile;
      notifyListeners();
    }
  }

  // Share profile
  Future<void> shareProfile() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate share functionality
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would implement actual share logic
      // await Share.share('Check out my profile: ${profile.name} - ${profile.jobTitle}');
      
      _setLoading(false);
    } catch (e) {
      _setError('Error sharing profile: $e');
      _setLoading(false);
    }
  }

  // Show more options
  void showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'More Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _OptionItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to settings
                },
              ),
              const SizedBox(height: 12),
              _OptionItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to help
                },
              ),
              const SizedBox(height: 12),
              _OptionItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to privacy policy
                },
              ),
              const SizedBox(height: 12),
              _OptionItem(
                icon: Icons.logout,
                title: 'Logout',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  // Implement logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigate to edit profile
  void navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileView(),
      ),
    );
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _OptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (color ?? const Color(0xFF5E7CE2)).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color ?? const Color(0xFF5E7CE2),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

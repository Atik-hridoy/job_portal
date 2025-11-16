import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SocialProvider { google, facebook, apple }

class SocialLoginButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey,
              ),
            )
          : _getProviderIcon(),
      label: Text(
        _getProviderName(),
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _getProviderIcon() {
    switch (provider) {
      case SocialProvider.google:
        return Icon(
          Icons.g_mobiledata,
          color: Colors.red,
          size: 24.sp,
        );
      case SocialProvider.facebook:
        return Icon(
          Icons.facebook,
          color: Colors.blue,
          size: 24.sp,
        );
      case SocialProvider.apple:
        return Icon(
          Icons.apple,
          color: Colors.black,
          size: 24.sp,
        );
    }
  }

  String _getProviderName() {
    switch (provider) {
      case SocialProvider.google:
        return 'Google';
      case SocialProvider.facebook:
        return 'Facebook';
      case SocialProvider.apple:
        return 'Apple';
    }
  }
}

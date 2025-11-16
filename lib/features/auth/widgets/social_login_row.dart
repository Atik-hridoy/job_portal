import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'social_login_button.dart';

class SocialLoginRow extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final bool isLoading;

  const SocialLoginRow({
    super.key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialLoginButton(
            provider: SocialProvider.google,
            onPressed: onGooglePressed,
            isLoading: isLoading,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SocialLoginButton(
            provider: SocialProvider.facebook,
            onPressed: onFacebookPressed,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/splash_controller.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/app_assets.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with error handling
            Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                AppAssets.appLogo,
                width: 150.w,
                height: 150.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150.w,
                    height: 150.h,
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 40.sp),
                        SizedBox(height: 8.h),
                        Text(
                          'Logo not found',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 32.h),
            
            // App Name
            Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1565C0),
              ),
            ),
            SizedBox(height: 12.h),
            
            // App Tagline
            Text(
              AppStrings.appTagline,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF757575),
              ),
            ),
            SizedBox(height: 48.h),
            
            // Loading Indicator
            FadeTransition(
              opacity: controller.loaderOpacity,
              child: SizedBox(
                width: 32.w,
                height: 32.h,
                child: CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                  strokeWidth: 3.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
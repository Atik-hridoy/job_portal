import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpSuccessView extends StatefulWidget {
  const OtpSuccessView({super.key});

  @override
  State<OtpSuccessView> createState() => _OtpSuccessViewState();
}

class _OtpSuccessViewState extends State<OtpSuccessView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _glowAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF6B73FF);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBFCFF), Color(0xFFF0F3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: const Color(0xFF4B527A),
                      size: 22.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width:
                                    220.w * _glowAnimation.value.clamp(0.4, 1),
                                height:
                                    220.w * _glowAnimation.value.clamp(0.4, 1),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: themeColor.withOpacity(
                                    0.08 * _glowAnimation.value,
                                  ),
                                ),
                              ),
                              Container(
                                width:
                                    180.w * _glowAnimation.value.clamp(0.6, 1),
                                height:
                                    180.w * _glowAnimation.value.clamp(0.6, 1),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                    0.3 * _glowAnimation.value,
                                  ),
                                ),
                              ),
                              ScaleTransition(
                                scale: _scaleAnimation,
                                child: Container(
                                  width: 140.w,
                                  height: 140.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6B73FF),
                                        Color(0xFF8E7CFF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: themeColor.withOpacity(0.35),
                                        blurRadius: 24,
                                        offset: const Offset(0, 18),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 76.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 36.h),
                      Text(
                        'Verification Successful',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF273056),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Your phone number has been verified. You can continue to explore the app.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF4B527A),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Navigate to home/dashboard when available.
                      Get.back();
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

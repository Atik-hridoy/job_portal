import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBFCFF), Color(0xFFF0F3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -140.h,
              left: -90.w,
              child: Container(
                width: 260.w,
                height: 260.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFEEF1FF), Color(0xFFDCE3FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -120.h,
              right: -80.w,
              child: Container(
                width: 240.w,
                height: 240.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFE3E9FF), Color(0xFFF7F8FF)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120.h,
              left: -40.w,
              child: Container(
                width: 140.w,
                height: 210.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFAFBFF), Color(0xFFDDE4FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeroGraphic(),
                          SizedBox(height: 36.h),
                          Text(
                            'We have sent OTP on your number',
                            style: TextStyle(
                              color: const Color(0xFF4B527A),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 22.h),
                          _buildCodeBoxes(),
                          SizedBox(height: 18.h),
                          _buildResendRow(),
                        ],
                      ),
                    ),
                    _buildKeypad(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          'Enter Verification Code',
          style: TextStyle(
            color: const Color(0xFF4B527A),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroGraphic() {
    return Center(
      child: Container(
        width: 150.w,
        height: 150.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.7),
        ),
        child: Center(
          child: Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFF8FAFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Icon(
                Icons.mark_email_read_outlined,
                size: 60.sp,
                color: const Color(0xFF6B73FF),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBoxes() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.codeController,
      builder: (_, value, __) {
        final text = value.text;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            final digit = index < text.length ? text[index] : '';
            return Container(
              width: 48.w,
              height: 48.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FF),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: digit.isNotEmpty
                      ? const Color(0xFF6B73FF)
                      : const Color(0xFFDEE3FF),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  digit,
                  style: TextStyle(
                    color: const Color(0xFF1F2456),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildResendRow() {
    return Obx(() {
      final ready = controller.isResendAvailable.value;
      final remaining = controller.secondsRemaining.value;
      return Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: const Color(0xFF4A5280),
              fontSize: 13.sp,
            ),
            children: [
              TextSpan(
                text: ready
                    ? "Didn't receive a OTP? "
                    : 'Resend OTP in ${remaining}s  ',
              ),
              TextSpan(
                text: 'Resend OTP',
                recognizer: TapGestureRecognizer()
                  ..onTap = ready ? controller.resendCode : null,
                style: TextStyle(
                  color: ready
                      ? const Color(0xFF6B73FF)
                      : const Color(0xFF6B73FF).withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildKeypad() {
    final buttons = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['<', '0', '✓'],
    ];

    return Column(
      children: buttons.map((row) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((label) {
              return _KeypadButton(
                label: label,
                onTap: () => _handleKey(label),
                themeColor: const Color(0xFF6B73FF),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  void _handleKey(String label) {
    final text = controller.codeController.text;
    if (label == '<') {
      if (text.isNotEmpty) {
        controller.codeController.text = text.substring(0, text.length - 1);
      }
    } else if (label == '✓') {
      controller.verifyCode();
    } else {
      if (text.length < 6) {
        controller.codeController.text = text + label;
      }
    }
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color themeColor;

  const _KeypadButton({
    required this.label,
    required this.onTap,
    this.themeColor = const Color(0xFF6B73FF),
  });

  @override
  Widget build(BuildContext context) {
    final bool isAction = label == '<' || label == '✓';
    final Color backgroundColor = isAction
        ? Colors.white.withOpacity(0.22)
        : Colors.white;
    final Color textColor = isAction ? themeColor : const Color(0xFF1F2456);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 58.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

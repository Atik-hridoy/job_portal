import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/routes/app_routers.dart';
import '../../../../core/repositories/auth_repository.dart';

class OtpController extends GetxController {
  final codeController = TextEditingController();
  final emailController = TextEditingController();
  final RxInt secondsRemaining = 60.obs;
  final RxBool isResendAvailable = false.obs;
  Timer? _timer;

  final RxBool isVerifying = false.obs;

  // Set email for OTP verification
  void setEmail(String email) {
    emailController.text = email;
  }

  @override
  void onInit() {
    super.onInit();
    
    // Get email from arguments
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['email'] != null) {
      emailController.text = arguments['email'];
    }
    
    _startTimer();
  }

  void _startTimer() {
    secondsRemaining.value = 60;
    isResendAvailable.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
        isResendAvailable.value = true;
      } else {
        secondsRemaining.value--;
      }
    });
  }

  Future<void> resendCode() async {
    if (!isResendAvailable.value) return;
    
    try {
      final email = emailController.text.trim();
      
      // Call real API
      final result = await AuthRepository().resendOtp(email);

      if (result['success'] == true) {
        Get.snackbar(
          'OTP Sent',
          result['message'] ?? 'A new verification code has been sent.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        _startTimer();
      } else {
        // API returned error
        Get.snackbar(
          'Error',
          result['error'] ?? 'Failed to resend OTP',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyCode() async {
    if (codeController.text.length != 6) {
      Get.snackbar(
        'Invalid Code',
        'Please enter a 6-digit verification code.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isVerifying.value = true;
      
      final email = emailController.text.trim();
      final otp = codeController.text;
      
      // Call real API
      final result = await AuthRepository().verifyOtp(email, otp);

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Phone number verified successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(Routes.otpSuccess);
      } else {
        // API returned error
        Get.snackbar(
          'Error',
          result['error'] ?? 'OTP verification failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'OTP verification failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    emailController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}

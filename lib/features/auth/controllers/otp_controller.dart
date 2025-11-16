import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final codeController = TextEditingController();
  final RxInt secondsRemaining = 60.obs;
  final RxBool isResendAvailable = false.obs;
  Timer? _timer;

  final RxBool isVerifying = false.obs;

  @override
  void onInit() {
    super.onInit();
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

  void resendCode() {
    if (!isResendAvailable.value) return;
    Get.snackbar(
      'OTP Sent',
      'A new verification code has been sent.',
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
    _startTimer();
  }

  Future<void> verifyCode() async {
    if (codeController.text.length != 6) {
      Get.snackbar(
        'Invalid Code',
        'Please enter the 6-digit verification code.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isVerifying.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Phone number verified successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Navigate to next screen when ready
      // Get.offAllNamed(Routes.home);
    } finally {
      isVerifying.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}

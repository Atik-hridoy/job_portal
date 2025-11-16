import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/auth_model.dart';
import 'package:job_portal/routes/app_routers.dart';

class SignInController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>(debugLabel: 'SignInForm');

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final Rxn<User> currentUser = Rxn<User>();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login function
  Future<void> login() async {
    try {
      isLoading.value = true;

      final loginRequest = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mock successful response
      final mockUser = User(
        id: '1',
        email: loginRequest.email,
        name: 'John Doe',
      );

      currentUser.value = mockUser;
      
      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to OTP verification
      Get.toNamed(Routes.otp);

    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Social login functions
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Google Sign In
      await Future.delayed(const Duration(seconds: 1));
      
      Get.snackbar(
        'Info',
        'Google Sign In - Coming Soon!',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Facebook Sign In
      await Future.delayed(const Duration(seconds: 1));
      
      Get.snackbar(
        'Info',
        'Facebook Sign In - Coming Soon!',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation functions
  void navigateToSignUp() {
    Get.offNamed('/signup');
  }

  void forgotPassword() {
    Get.snackbar(
      'Info',
      'Forgot Password - Coming Soon!',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  // Validation functions
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Lifecycle methods
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

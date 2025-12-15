import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/repositories/auth_repository.dart';
import 'package:job_portal/routes/app_routers.dart';

class SignUpController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>(debugLabel: 'SignUpForm');

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString selectedUserType = 'Job Seeker'.obs;

  final List<String> userTypes = const ['Hirer', 'Job Seeker'];

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setUserType(String? value) {
    if (value == null) return;
    selectedUserType.value = value;
  }

  // Sign up function
  Future<void> signUp() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text;
      final phone = phoneController.text.trim();
      final role = selectedUserType.value.toLowerCase() == 'job seeker' ? 'job_seeker' : 'hirer';

      // Call real API
      final result = await AuthRepository().signUp(email, password, role, phone);

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to OTP verification with email
        Get.toNamed(Routes.otp, arguments: {'email': email});
      } else {
        // API returned error
        Get.snackbar(
          'Error',
          result['error'] ?? 'Sign up failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign up failed: ${e.toString()}',
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
  void navigateToLogin() {
    Get.offNamed('/login');
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

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Lifecycle methods

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }
}

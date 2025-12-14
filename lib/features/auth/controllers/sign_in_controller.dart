import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/auth_model.dart';
import 'package:job_portal/routes/app_routers.dart';
import '../../../../core/repositories/auth_repository.dart';
import '../../../../core/services/storage_service.dart';

class SignInController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>(debugLabel: 'SignInForm');

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Storage is now handled by StorageService

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;
  final Rxn<User> currentUser = Rxn<User>();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Save token
  void _saveToken(String? token) async {
    if (token != null) {
      await StorageService.saveToken(token);
    }
  }

  // Save credentials
  void _saveCredentials() async {
    if (rememberMe.value) {
      await StorageService.saveData('remembered_email', emailController.text);
      await StorageService.saveData('remembered_password', passwordController.text);
      await StorageService.saveData('remember_me', true);
    } else {
      await StorageService.removeData('remembered_email');
      await StorageService.removeData('remembered_password');
      await StorageService.removeData('remember_me');
    }
  }

  // Check if user is already logged in
  bool isLoggedIn() {
    final token = StorageService.getToken();
    return token != null && token.isNotEmpty;
  }

  // Load saved credentials
  void _loadSavedCredentials() {
    rememberMe.value = StorageService.readData('remember_me') ?? false;
    if (rememberMe.value) {
      emailController.text = StorageService.readData('remembered_email') ?? '';
      passwordController.text = StorageService.readData('remembered_password') ?? '';
    }
  }

  // Login function
  Future<void> login() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text;

      // Call real API
      final result = await AuthRepository().signIn(email, password);

      if (result['success'] == true) {
        // Save token and credentials
        _saveToken(result['token']);
        _saveCredentials();
        
        // Create user from API response
        final userData = result['user'] ?? result['data'];
        currentUser.value = User(
          id: userData['id']?.toString() ?? '1',
          email: userData['email'] ?? email,
          name: userData['name'] ?? 'User',
        );
        
        Get.snackbar(
          'Success',
          result['message'] ?? 'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to get started page
        Get.offAllNamed(Routes.getStarted);
      } else {
        // API returned error
        Get.snackbar(
          'Error',
          result['error'] ?? 'Login failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

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
    _loadSavedCredentials();
  }

  @override
  void onReady() {
    super.onReady();
    
    // Check if user is already logged in and on login screen
    if (isLoggedIn() && Get.currentRoute == '/login') {
      // Auto-redirect to home if already logged in
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.getStarted);
      });
    }
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

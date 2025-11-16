import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController logoController;
  late AnimationController titleController;
  late AnimationController subtitleController;
  late AnimationController loaderController;
  
  // Animation values
  late Animation<double> logoScale;
  late Animation<double> titleOpacity;
  late Animation<double> subtitleOpacity;
  late Animation<double> loaderOpacity;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _startAnimationSequence();
    _navigateToNext();
  }

  void _initializeAnimations() {
    // Logo animation
    logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    logoScale = CurvedAnimation(
      parent: logoController,
      curve: Curves.elasticOut,
    );

    // Title animation
    titleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    titleOpacity = titleController;

    // Subtitle animation
    subtitleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    subtitleOpacity = subtitleController;

    // Loader animation
    loaderController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    loaderOpacity = loaderController;
  }

  void _startAnimationSequence() {
    // Start logo immediately
    logoController.forward();
    
    // Start title after 400ms
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!isClosed) titleController.forward();
    });
    
    // Start subtitle after 600ms
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!isClosed) subtitleController.forward();
    });
    
    // Start loader after 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isClosed) loaderController.forward();
    });
  }

  void _navigateToNext() async {
    // Wait for animations to complete + splash duration
    await Future.delayed(const Duration(seconds: 3));
    
    // Navigate to onboarding screen
    if (!isClosed) {
      Get.offAllNamed('/onboarding');
    }
  }

  @override
  void onClose() {
    logoController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    loaderController.dispose();
    super.onClose();
  }
}

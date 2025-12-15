import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPageIndex = 0.obs;
  final List<OnboardingModel> onboardingPages = OnboardingModel.getOnboardingPages();


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }

  void nextPage() {
    if (currentPageIndex.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login or home screen
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    // Navigate to login screen
    Get.offAllNamed('/login');
  }

  bool get isLastPage => currentPageIndex.value == onboardingPages.length - 1;
  bool get isFirstPage => currentPageIndex.value == 0;
}

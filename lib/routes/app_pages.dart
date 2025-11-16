import 'package:get/get.dart';
import 'package:job_portal/features/splash/views/splash_view.dart';
import 'package:job_portal/features/splash/bindings/splash_binding.dart';
import 'package:job_portal/features/onboarding/views/onboarding_view.dart';
import 'package:job_portal/features/onboarding/bindings/onboarding_binding.dart';
import 'package:job_portal/features/auth/views/sign_in_view.dart';
import 'package:job_portal/features/auth/views/sign_up_view.dart';
import 'package:job_portal/features/auth/views/otp_view.dart';
import 'package:job_portal/features/auth/bindings/auth_binding.dart';
import 'package:job_portal/routes/app_routers.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash, 
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.login,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // Add your home route here when ready
    // GetPage(
    //   name: Routes.home,
    //   page: () => const HomeScreen(),
    //   binding: HomeBinding(),
    //   transition: Transition.fadeIn,
    // ),
  ];
}
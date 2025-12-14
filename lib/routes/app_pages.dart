import 'package:get/get.dart';
import 'package:job_portal/features/splash/views/splash_view.dart';
import 'package:job_portal/features/splash/bindings/splash_binding.dart';
import 'package:job_portal/features/onboarding/views/onboarding_view.dart';
import 'package:job_portal/features/onboarding/bindings/onboarding_binding.dart';
import 'package:job_portal/features/auth/views/sign_in_view.dart';
import 'package:job_portal/features/auth/views/sign_up_view.dart';
import 'package:job_portal/features/auth/views/otp_view.dart';
import 'package:job_portal/features/auth/views/otp_success_view.dart';
import 'package:job_portal/features/auth/bindings/auth_binding.dart';
import 'package:job_portal/features/home/views/home_view.dart';
import 'package:job_portal/features/home/bindings/home_binding.dart';
import 'package:job_portal/features/get_started/views/get_start_view.dart';
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
      name: Routes.getStarted,
      page: () => const GetStartView(),
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
    GetPage(
      name: Routes.otpSuccess,
      page: () => const OtpSuccessView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
import 'package:get/get.dart';
import '../controllers/sign_in_controller.dart';
import '../controllers/sign_up_controller.dart';
import '../controllers/otp_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Only put controllers when needed to avoid GlobalKey conflicts
  }
}

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(SignInController());
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtpController>(OtpController());
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/auth_background.dart';
import '../widgets/password_field.dart';
import '../widgets/social_login_row.dart';
import '../../../core/widgets/common/custom_text_field.dart';
import '../../../core/widgets/common/custom_button.dart';
import '../../../core/utils/app_assets.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: 'Sign up',
      enableScroll: true,
      iconAsset: AppAssets.signUpIcon,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
              // Email field
              CustomTextField(
                controller: controller.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),

              // Password field
              Obx(() => PasswordField(
                controller: controller.passwordController,
                isPasswordVisible: controller.isPasswordVisible.value,
                onToggleVisibility: controller.togglePasswordVisibility,
              )),
              SizedBox(height: 16.h),

              // Phone field
              CustomTextField(
                controller: controller.phoneController,
                hintText: 'Phone',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.h),

              // Sign Up button
              Obx(() => CustomButton(
                text: 'Sign Up',
                onPressed: controller.signUp,
                isLoading: controller.isLoading.value,
              )),
              SizedBox(height: 16.h),

              // Terms and conditions
              Center(
                child: Text(
                  'By clicking this button, you agree with\nour Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Social login buttons
              SocialLoginRow(
                onGooglePressed: controller.loginWithGoogle,
                onFacebookPressed: controller.loginWithFacebook,
                isLoading: controller.isLoading.value,
              ),
              SizedBox(height: 20.h),

              // Sign in link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToLogin,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: const Color(0xFF6B73FF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

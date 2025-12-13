import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/auth_background.dart';
import '../widgets/password_field.dart';
import '../widgets/social_login_row.dart';
import '../../../core/widgets/common/custom_text_field.dart';
import '../../../core/widgets/common/custom_button.dart';
import '../../../core/utils/app_assets.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: 'Sign in',
      iconAsset: AppAssets.signInIcon,
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

            // Remember Me checkbox
            Obx(() => Row(
              children: [
                Checkbox(
                  value: controller.rememberMe.value,
                  onChanged: (value) {
                    controller.rememberMe.value = value ?? false;
                  },
                  activeColor: const Color(0xFF6B73FF),
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            )),
            SizedBox(height: 16.h),

            // Sign In button
            Obx(() => CustomButton(
              text: 'Sign In',
              onPressed: controller.login,
              isLoading: controller.isLoading.value,
            )),
            SizedBox(height: 16.h),

            // Forgot password
            Center(
              child: TextButton(
                onPressed: controller.forgotPassword,
                child: Text(
                  'Forget your password?',
                  style: TextStyle(
                    color: const Color(0xFF6B73FF),
                    fontSize: 14.sp,
                  ),
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

            // Sign up link
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.navigateToSignUp,
                    child: Text(
                      'Sign up',
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
          ],
        ),
      ),
    );
  }
}

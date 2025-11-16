import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/common/custom_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPasswordVisible;
  final VoidCallback onToggleVisibility;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isPasswordVisible,
    required this.onToggleVisibility,
    this.hintText = 'Password',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      validator: validator,
      obscureText: !isPasswordVisible,
      suffixIcon: IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey.shade400,
          size: 20.sp,
        ),
      ),
    );
  }
}

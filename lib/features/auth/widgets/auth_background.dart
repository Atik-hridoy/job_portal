import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String? iconAsset;
  final bool enableScroll;

  const AuthBackground({
    super.key,
    required this.child,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.iconAsset,
    this.enableScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Top decorative area with optional back button
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      if (iconAsset != null)
                        Positioned.fill(
                          child: Transform.scale(
                            scale: 1.08,
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              iconAsset!,
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade200),
                            ),
                          ),
                        ),

                      // Content overlay
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.transparent],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              children: [
                                if (showBackButton)
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: iconAsset != null ? Colors.white : Colors.black,
                                          size: 24.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                const Spacer(),
                                // Centered decorative elements
                                _buildMainContent(),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom white container with content
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F5FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B73FF).withOpacity(0.12),
                        blurRadius: 18,
                        spreadRadius: 2,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: iconAsset != null ? 30.h : 10.h),
                            // Title
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: (constraints.maxHeight * 0.08).clamp(24.sp, 32.sp),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: (constraints.maxHeight * 0.06).clamp(20.h, 30.h)),
                            // Content - responsive to available space
                            Expanded(
                              child: _buildBodyContent(constraints),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main centered icon removed - clean design only
        
        // Minimal decorative elements
        _buildDecorativeElements(),
      ],
    );
  }

  Widget _buildDecorativeElements() {
    return Column(
      children: [
        // Decorative circles
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDecorativeCircle(Colors.grey.withOpacity(0.2), 30.r),
            _buildDecorativeCircle(Colors.grey.withOpacity(0.1), 40.r),
            _buildDecorativeCircle(Colors.grey.withOpacity(0.15), 25.r),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDecorativeCircle(Colors.grey.withOpacity(0.1), 15.r),
            SizedBox(width: 30.w),
            _buildDecorativeCircle(Colors.grey.withOpacity(0.2), 20.r),
          ],
        ),
      ],
    );
  }

  Widget _buildDecorativeCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildBodyContent(BoxConstraints constraints) {
    final content = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: constraints.maxHeight * 0.7,
      ),
      child: child,
    );

    if (!enableScroll) {
      return content;
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: content,
    );
  }
}

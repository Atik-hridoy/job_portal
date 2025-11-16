// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// /// 🔥 Universal responsive wrapper for all screens.
// /// Ensures consistent user experience across Android, iOS, tablets, and foldables.
// /// Background color covers full screen while content respects SafeArea.
// class ResponsiveWrapper extends StatelessWidget {
//   final Widget child;
//   final bool scrollable;
//   final bool center;
//   final EdgeInsets? padding;
//   final Color? backgroundColor;

//   const ResponsiveWrapper({
//     super.key,
//     required this.child,
//     this.scrollable = false,
//     this.center = false,
//     this.padding,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final size = MediaQuery.of(context).size;
    
//     // Calculate responsive padding
//     final horizontalPadding = _getHorizontalPadding(size.width);
//     final verticalPadding = _getVerticalPadding(size.height);

//     final defaultPadding = EdgeInsets.symmetric(
//       horizontal: horizontalPadding,
//       vertical: verticalPadding,
//     );

//     Widget content = child;

//     // Apply centering if requested
//     if (center) {
//       content = Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: size.width > 800 ? 800 : double.infinity,
//           ),
//           child: content,
//         ),
//       );
//     }

//     // Apply padding within SafeArea
//     content = Padding(
//       padding: padding ?? defaultPadding,
//       child: content,
//     );

//     // Add gesture detection for keyboard dismissal
//     content = GestureDetector(
//       onTap: () {
//         // Dismiss keyboard on tap outside
//         final currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//           currentFocus.focusedChild!.unfocus();
//           HapticFeedback.selectionClick();
//         }
//       },
//       child: content,
//     );

//     // Wrap with SafeArea for content positioning
//     content = SafeArea(
//       child: content,
//     );

//     // Container with background color that covers full screen
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: backgroundColor ?? Colors.transparent,
//       child: content,
//     );
//   }

//   double _getHorizontalPadding(double screenWidth) {
//     if (screenWidth > 1200) return 48.0; // Desktop
//     if (screenWidth > 800) return 32.0;  // Large tablet
//     if (screenWidth > 600) return 24.0;  // Small tablet
//     return 16.0; // Phone
//   }

//   double _getVerticalPadding(double screenHeight) {
//     if (screenHeight > 900) return 24.0; // Tall screens
//     if (screenHeight > 700) return 16.0; // Normal screens
//     return 12.0; // Short screens
//   }
// }
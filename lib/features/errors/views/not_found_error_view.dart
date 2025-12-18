import 'package:flutter/material.dart';

import '../widgets/error_screen_template.dart';

class NotFoundErrorView extends StatelessWidget {
  const NotFoundErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreenTemplate(
      headline: "We couldn't find that",
      message:
          "The page you're looking for has moved or never existed. Double-check the URL or head back to safety.",
      primaryActionLabel: 'Back to home',
      onPrimaryAction: () => Navigator.of(context).maybePop(),
      secondaryActionLabel: 'Report this issue',
      onSecondaryAction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Issue reported.')),
        );
      },
      gradient: const [
        Color(0xFF1D2671),
        Color(0xFFC33764),
      ],
      accentColor: const Color(0xFFC33764),
      icon: Icons.search_off_rounded,
    );
  }
}

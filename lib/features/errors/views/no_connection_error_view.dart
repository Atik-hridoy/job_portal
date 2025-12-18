import 'package:flutter/material.dart';

import '../widgets/error_screen_template.dart';

class NoConnectionErrorView extends StatelessWidget {
  const NoConnectionErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreenTemplate(
      headline: "You're offline",
      message:
          "We can't reach the network right now. Check your Wi-Fi or cellular data, then try again in a moment.",
      primaryActionLabel: 'Retry',
      onPrimaryAction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Retrying...')),
        );
      },
      secondaryActionLabel: 'Open settings',
      onSecondaryAction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening settings...')),
        );
      },
      gradient: const [
        Color(0xFF0F2027),
        Color(0xFF203A43),
        Color(0xFF2C5364),
      ],
      accentColor: const Color(0xFF2C5364),
      icon: Icons.wifi_off_rounded,
    );
  }
}

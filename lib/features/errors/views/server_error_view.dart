import 'package:flutter/material.dart';

import '../widgets/error_screen_template.dart';

class ServerErrorView extends StatelessWidget {
  const ServerErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreenTemplate(
      headline: 'Something broke on our side',
      message:
          "Our servers ran into a hiccup while processing your request. We're already looking into it—please try again shortly.",
      primaryActionLabel: 'Try again',
      onPrimaryAction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Retrying...')),
        );
      },
      secondaryActionLabel: 'Contact support',
      onSecondaryAction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening support chat...')),
        );
      },
      gradient: const [
        Color(0xFF373B44),
        Color(0xFF4286F4),
      ],
      accentColor: const Color(0xFF4286F4),
      icon: Icons.cloud_off_rounded,
    );
  }
}

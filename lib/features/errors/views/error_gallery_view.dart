import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../errors/views/no_connection_error_view.dart';
import '../../errors/views/not_found_error_view.dart';
import '../../errors/views/server_error_view.dart';
import '../../../routes/app_routers.dart';

class ErrorGalleryView extends StatelessWidget {
  const ErrorGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101014),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Error States',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.2),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          const _Headline(label: 'Available screens'),
          const SizedBox(height: 16),
          _ErrorCard(
            title: '404 — Not Found',
            subtitle: 'Use when a screen or content is missing or inaccessible',
            gradient: const [Color(0xFF1D2671), Color(0xFFC33764)],
            onTap: () => Get.to(() => const NotFoundErrorView()),
          ),
          const SizedBox(height: 16),
          _ErrorCard(
            title: 'Offline — No Connection',
            subtitle: 'Show whenever the device drops network connectivity',
            gradient: const [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            onTap: () => Get.to(() => const NoConnectionErrorView()),
          ),
          const SizedBox(height: 16),
          _ErrorCard(
            title: '500 — Server Error',
            subtitle: 'Rendered when backend services fail unexpectedly',
            gradient: const [Color(0xFF373B44), Color(0xFF4286F4)],
            onTap: () => Get.to(() => const ServerErrorView()),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => Get.offAllNamed(Routes.home),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF5E7CE2),
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.home_rounded),
            label: const Text(
              'Return to main app',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _ErrorCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  final String label;

  const _Headline({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    );
  }
}

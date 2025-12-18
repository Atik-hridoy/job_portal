import 'package:flutter/material.dart';

class PostEmptyState extends StatelessWidget {
  const PostEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5E7CE2).withOpacity(0.14),
              ),
              child: const Icon(
                Icons.feed_rounded,
                color: Color(0xFF5E7CE2),
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No posts yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '''Be the first one to share your journey,
ask a question or celebrate an achievement.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

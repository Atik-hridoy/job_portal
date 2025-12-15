import 'package:flutter/material.dart';
import 'stat_card.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.work_outline,
            value: '12',
            label: 'Applications',
            color: const Color(0xFF5E7CE2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.bookmark_outline,
            value: '28',
            label: 'Saved Jobs',
            color: const Color(0xFFE25E7C),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.visibility_outlined,
            value: '156',
            label: 'Profile Views',
            color: const Color(0xFF4DB8AC),
          ),
        ),
      ],
    );
  }
}

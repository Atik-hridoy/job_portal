import 'package:flutter/material.dart';

class SearchFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const SearchFilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isActive
        ? const Color(0xFF5E7CE2).withOpacity(0.25)
        : Colors.white.withOpacity(0.08);
    final Color borderColor = isActive
        ? const Color(0xFF5E7CE2).withOpacity(0.6)
        : Colors.white.withOpacity(0.15);
    final Color textColor = isActive ? Colors.white : Colors.white70;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

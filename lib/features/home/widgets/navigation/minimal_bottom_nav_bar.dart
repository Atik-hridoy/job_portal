import 'package:flutter/material.dart';

class MinimalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MinimalBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMinimalNavItem(0, Icons.home_rounded, 'Home'),
            _buildMinimalNavItem(1, Icons.search_rounded, 'Search'),
            _buildMinimalNavItem(2, Icons.message_rounded, 'Message'),
            _buildMinimalNavItem(3, Icons.person_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Animated circle background
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.lerp(
                        Colors.transparent,
                        const Color(0xFF5E7CE2).withOpacity(0.2),
                        value,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    icon,
                    color: Color.lerp(
                      Colors.white.withOpacity(0.5),
                      const Color(0xFF5E7CE2),
                      value,
                    ),
                    size: 24 + (value * 2),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: Color.lerp(
                    Colors.white.withOpacity(0.5),
                    const Color(0xFF5E7CE2),
                    value,
                  ),
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(label),
              ),
              const SizedBox(height: 2),
              // Animated indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 6 : 0,
                height: isSelected ? 6 : 0,
                decoration: const BoxDecoration(
                  color: Color(0xFF5E7CE2),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

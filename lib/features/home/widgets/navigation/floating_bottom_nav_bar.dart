import 'package:flutter/material.dart';

class FloatingBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    _scaleAnimations = _controllers
        .map((controller) => Tween<double>(begin: 1.0, end: 1.3).animate(
              CurvedAnimation(parent: controller, curve: Curves.elasticOut),
            ))
        .toList();
    _fadeAnimations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            ))
        .toList();

    _controllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(FloatingBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFloatingNavItem(0, Icons.home_rounded, 'Home'),
          _buildFloatingNavItem(1, Icons.search_rounded, 'Search'),
          _buildFloatingNavItem(2, Icons.message_rounded, 'Message'),
          _buildFloatingNavItem(3, Icons.person_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFloatingNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () {
        widget.onTap(index);
        _controllers[index].forward().then((_) {
          _controllers[index].reverse();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF5E7CE2), Color(0xFF4DB8AC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimations[index],
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                size: isSelected ? 28 : 24,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              FadeTransition(
                opacity: _fadeAnimations[index],
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

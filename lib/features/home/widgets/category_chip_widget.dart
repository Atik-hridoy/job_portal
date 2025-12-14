import 'package:flutter/material.dart';


  class CategoryChipWidget extends StatefulWidget {
  final String label;
  final Color color;
  final bool outlined;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  const CategoryChipWidget(
    this.label,
    this.color, {
    this.outlined = false,
    this.isSelected = false,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryChipWidget> createState() => _CategoryChipWidgetState();
}

class _CategoryChipWidgetState extends State<CategoryChipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 22 : 18,
            vertical: isTablet ? 14 : 12,
          ),
          decoration: BoxDecoration(
            // Gradient for selected or solid chips
            gradient: widget.outlined
                ? null
                : (widget.isSelected
                    ? LinearGradient(
                        colors: [
                          widget.color,
                          widget.color.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [widget.color, widget.color],
                      )),
            color: widget.outlined ? Colors.transparent : null,
            border: widget.outlined
                ? Border.all(
                    color: widget.isSelected
                        ? widget.color
                        : Colors.white.withOpacity(0.3),
                    width: widget.isSelected ? 2 : 1.5,
                  )
                : null,
            borderRadius: BorderRadius.circular(24),
            boxShadow: widget.isSelected && !widget.outlined
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.outlined
                      ? (widget.isSelected
                          ? widget.color
                          : Colors.white.withOpacity(0.8))
                      : Colors.white,
                  size: isTablet ? 20 : 18,
                ),
                SizedBox(width: isTablet ? 8 : 6),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.outlined
                      ? (widget.isSelected
                          ? widget.color
                          : Colors.white.withOpacity(0.8))
                      : Colors.white,
                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: isTablet ? 17 : 15,
                  letterSpacing: 0.2,
                ),
              ),
              // Animated checkmark for selected state
              if (widget.isSelected && !widget.outlined) ...[
                SizedBox(width: isTablet ? 8 : 6),
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: isTablet ? 18 : 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }


  
}
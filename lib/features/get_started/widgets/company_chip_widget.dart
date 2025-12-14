import 'package:flutter/material.dart';

class CompanyChipWidget extends StatefulWidget {
  final String name;
  final Color color;
  final String? logoUrl;

  const CompanyChipWidget({
    Key? key,
    required this.name,
    required this.color,
    this.logoUrl,
  }) : super(key: key);

  @override
  State<CompanyChipWidget> createState() => _CompanyChipWidgetState();
}

class _CompanyChipWidgetState extends State<CompanyChipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000 + (widget.name.hashCode % 1000)),
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 8 + _floatAnimation.value.abs(),
                  offset: Offset(0, 2 + _floatAnimation.value.abs() / 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.logoUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.logoUrl!,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.business,
                            size: 12,
                            color: widget.color.computeLuminance() > 0.5 
                                ? Colors.black 
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  widget.name,
                  style: TextStyle(
                    color: widget.color.computeLuminance() > 0.5 
                        ? Colors.black 
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

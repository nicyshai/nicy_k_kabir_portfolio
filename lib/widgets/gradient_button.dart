import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

enum ButtonStyleType { filled, outlined }

/// Premium pill-shaped button with a hover-lift animation and ripple.
/// Used for "Get In Touch", "Download Resume", "View Projects", etc.
class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final ButtonStyleType type;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = ButtonStyleType.filled,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isFilled = widget.type == ButtonStyleType.filled;
    final borderColor = Theme.of(context).colorScheme.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onPressed,
            child: Ink(
              decoration: BoxDecoration(
                gradient: isFilled ? AppColors.brandGradient : null,
                color: isFilled ? null : Colors.transparent,
                border: isFilled
                    ? null
                    : Border.all(color: borderColor.withValues(alpha: 0.6)),
                borderRadius: BorderRadius.circular(999),
                boxShadow: isFilled && _hovering
                    ? [
                        BoxShadow(
                          color: AppColors.brandCyan.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon,
                        size: 18,
                        color: isFilled ? Colors.white : borderColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: isFilled ? Colors.white : borderColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

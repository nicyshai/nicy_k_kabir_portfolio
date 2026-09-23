import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../themes/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final textAlign =
        alignment == CrossAxisAlignment.center ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.brandGradient.createShader(bounds),
          child: Text(
            eyebrow.toUpperCase(),
            textAlign: textAlign,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: textAlign,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15, end: 0);
  }
}

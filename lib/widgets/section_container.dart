import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/responsive.dart';

/// Wraps every page section with consistent max-width, horizontal
/// padding, vertical rhythm, and an optional alternate background
/// tint so sections visually separate without hard borders.
class SectionContainer extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;
  final bool alternate;

  const SectionContainer({
    required this.sectionKey,
    required this.child,
    this.alternate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: alternate
          ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.5)
          : Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: isMobile ? 56 : 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: AppConstants.desktopContentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}

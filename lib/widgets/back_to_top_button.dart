import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/app_theme.dart';
import '../viewmodels/navigation_view_model.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationViewModel>();

    return Positioned(
      bottom: 28,
      right: 28,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: nav.showBackToTop ? Offset.zero : const Offset(0, 2),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: nav.showBackToTop ? 1 : 0,
          child: IgnorePointer(
            ignoring: !nav.showBackToTop,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: nav.scrollToTop,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.brandGradient,
                  ),
                  child: const Icon(Icons.keyboard_arrow_up_rounded,
                      color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

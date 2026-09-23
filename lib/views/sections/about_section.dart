import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/profile_model.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  final ProfileModel profile;
  const AboutSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    final isMobile = Responsive.isMobile(context);

    final highlights = [
      _Highlight(Icons.school_rounded, 'Background',
          'From Economics & Education into Flutter engineering'),
      _Highlight(Icons.flutter_dash_rounded, 'Focus',
          'Cross-platform mobile apps with Flutter & Dart'),
      _Highlight(Icons.rocket_launch_rounded, 'Goal',
          'Building scalable, MVVM-driven mobile experiences'),
    ];

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secAbout),
      alternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'About Me',
            title: 'Getting to know my journey',
          ),
          const SizedBox(height: 36),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _maybeExpanded(
                isExpanded: !isMobile,
                flex: 3,
                child: Text(
                  profile.summary.resolve(context),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 32 : 0),
              _maybeExpanded(
                isExpanded: !isMobile,
                flex: 2,
                child: Column(
                  children: [
                    for (int i = 0; i < highlights.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: i == highlights.length - 1 ? 0 : 16),
                        child: _HighlightCard(item: highlights[i], index: i),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _maybeExpanded({
    required bool isExpanded,
    required int flex,
    required Widget child,
  }) {
    return isExpanded ? Expanded(flex: flex, child: child) : child;
  }
}

class _Highlight {
  final IconData icon;
  final String label;
  final String description;
  _Highlight(this.icon, this.label, this.description);
}

class _HighlightCard extends StatelessWidget {
  final _Highlight item;
  final int index;
  const _HighlightCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(item.description,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (150 * index).ms, duration: 500.ms).slideX(begin: 0.1, end: 0);
  }
}

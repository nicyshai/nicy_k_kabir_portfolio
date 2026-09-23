import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/certificate_model.dart';
import '../../themes/app_theme.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/navigation_view_model.dart';

/// Renders nothing when the resume has no achievements listed --
/// per the "hide missing sections" requirement, this section simply
/// isn't inserted into the page when data is empty.
class AchievementsSection extends StatelessWidget {
  final List<AchievementModel> achievements;
  const AchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) return const SizedBox.shrink();
    final nav = context.read<NavigationViewModel>();

    return SectionContainer(
      sectionKey: nav.keyFor('achievements'),
      alternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Achievements', title: 'Milestones & recognition'),
          const SizedBox(height: 36),
          for (int i = 0; i < achievements.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AchievementTile(item: achievements[i], index: i),
            ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final AchievementModel item;
  final int index;
  const _AchievementTile({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_rounded, color: AppColors.accentAmber, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(item.description.resolve(context), style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (120 * index).ms, duration: 450.ms);
  }
}

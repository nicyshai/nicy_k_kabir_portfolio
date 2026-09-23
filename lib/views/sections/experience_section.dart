import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/experience_model.dart';
import '../../themes/app_theme.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  final List<ExperienceModel> experience;
  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (experience.isEmpty) return const SizedBox.shrink();

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secExperience),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Experience',
            title: 'Where I\'ve worked',
          ),
          const SizedBox(height: 36),
          for (int i = 0; i < experience.length; i++)
            _TimelineTile(
              isLast: i == experience.length - 1,
              index: i,
              child: _ExperienceCard(item: experience[i]),
            ),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final Widget child;
  final bool isLast;
  final int index;
  const _TimelineTile({required this.child, required this.isLast, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 7, // Center of the 16px circle (16/2 - 2/2 = 7)
            top: 22, // Below the 16px circle (6px margin + 16px height)
            bottom: 0,
            child: Container(
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                gradient: AppColors.brandGradient,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: child,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: (150 * index).ms, duration: 500.ms).slideX(begin: 0.08, end: 0);
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel item;
  const _ExperienceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 6,
            children: [
              Text(item.role, style: Theme.of(context).textTheme.titleLarge),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(item.duration,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(item.company,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),
          for (final r in item.responsibilities)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, size: 6, color: AppColors.brandCyan),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(r, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

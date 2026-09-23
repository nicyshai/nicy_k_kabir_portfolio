import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/education_model.dart';
import '../../themes/app_theme.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class EducationSection extends StatelessWidget {
  final List<EducationModel> education;
  const EducationSection({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (education.isEmpty) return const SizedBox.shrink();

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secEducation),
      alternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(eyebrow: 'Education', title: 'Academic background'),
          const SizedBox(height: 36),
          for (int i = 0; i < education.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _EducationCard(item: education[i], index: i),
            ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final EducationModel item;
  final int index;
  const _EducationCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.school_rounded, color: Colors.white),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.degree, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(item.institution, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                Text(item.duration,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (150 * index).ms, duration: 500.ms).slideX(begin: 0.08, end: 0);
  }
}

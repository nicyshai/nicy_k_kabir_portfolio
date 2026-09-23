import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/skill_model.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  final List<SkillCategoryModel> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (skills.isEmpty) return const SizedBox.shrink();

    final columns = Responsive.deviceTypeOf(context) == DeviceType.mobile
        ? 1
        : (Responsive.deviceTypeOf(context) == DeviceType.tablet ? 2 : 3);

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secSkills),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Skills',
            title: 'Technologies I work with',
            subtitle:
                'A toolkit built around Flutter, Dart, and modern app architecture.',
          ),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 220,
            ),
            itemBuilder: (context, index) =>
                _SkillCard(category: skills[index], index: index),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillCategoryModel category;
  final int index;
  const _SkillCard({required this.category, required this.index});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovering
                ? AppColors.brandCyan.withValues(alpha: 0.6)
                : Theme.of(context).dividerColor,
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: AppColors.brandCyan.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.brandGradient.createShader(b),
              child: Text(
                widget.category.category,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.category.items
                    .map((s) => _SkillChip(label: s))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (100 * widget.index).ms, duration: 450.ms)
        .slideY(begin: 0.12, end: 0);
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

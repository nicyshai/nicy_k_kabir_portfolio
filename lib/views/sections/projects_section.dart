import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/project_model.dart';
import '../../services/launcher_service.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  final List<ProjectModel> projects;
  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (projects.isEmpty) return const SizedBox.shrink();

    final columns = Responsive.projectGridColumns(context);

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secProjects),
      alternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Projects',
            title: 'Things I\'ve built',
            subtitle: 'A selection of Flutter applications from my project work.',
          ),
          const SizedBox(height: 36),
          if (projects.length == 1)
            _ProjectCard(project: projects.first, index: 0)
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                mainAxisExtent: 480,
              ),
              itemBuilder: (context, index) =>
                  _ProjectCard(project: projects[index], index: index),
            ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return SizedBox(
      height: 480,
      child: MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovering ? -8 : 0, 0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovering
                ? AppColors.brandCyan.withValues(alpha: 0.6)
                : Theme.of(context).dividerColor,
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: AppColors.brandCyan.withValues(alpha: 0.18),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder application preview (no screenshot was
            // provided in the resume), styled as a mock phone frame.
            SizedBox(
              height: 200,
              width: double.infinity,
              child: _AppPreviewPlaceholder(hovering: _hovering),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        p.description.resolve(context),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: p.technologies
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor),
                                ),
                                child: Text(t,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w600)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (p.github != null)
                          _LinkButton(
                            icon: Icons.code_rounded,
                            label: 'GitHub',
                            onTap: () => LauncherService.open(p.github!),
                          ),
                        if (p.liveDemo != null) ...[
                          const SizedBox(width: 12),
                          _LinkButton(
                            icon: Icons.public_rounded,
                            label: 'Live Demo',
                            onTap: () => LauncherService.open(p.liveDemo!),
                          ),
                        ],
                        if (p.apk != null) ...[
                          const SizedBox(width: 12),
                          _LinkButton(
                            icon: Icons.android_rounded,
                            label: 'APK',
                            onTap: () => LauncherService.open(p.apk!),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    ).animate().fadeIn(delay: (120 * widget.index).ms, duration: 500.ms).slideY(begin: 0.1, end: 0);
  }
}

class _AppPreviewPlaceholder extends StatelessWidget {
  final bool hovering;
  const _AppPreviewPlaceholder({required this.hovering});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.brandGradient),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -20,
            top: -20,
            child: Icon(Icons.flutter_dash_rounded,
                size: 90, color: Colors.white.withValues(alpha: 0.15)),
          ),
          AnimatedScale(
            duration: const Duration(milliseconds: 220),
            scale: hovering ? 1.06 : 1,
            child: Container(
              width: 92,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withValues(alpha: 0.2), width: 3),
              ),
              child: const Icon(Icons.smartphone_rounded,
                  color: AppColors.brandBlue, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _LinkButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}

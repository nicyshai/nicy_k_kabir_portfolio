import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/service_model.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class ServicesSection extends StatelessWidget {
  final List<ServiceModel> services;
  const ServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (services.isEmpty) return const SizedBox.shrink();

    final columns = Responsive.deviceTypeOf(context) == DeviceType.mobile
        ? 1
        : (Responsive.deviceTypeOf(context) == DeviceType.tablet ? 2 : 3);

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secServices),
      alternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Services',
            title: 'How I can help',
            subtitle: 'Services derived from my core skill set and hands-on experience.',
          ),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 210,
            ),
            itemBuilder: (context, i) => _ServiceCard(service: services[i], index: i),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final int index;
  const _ServiceCard({required this.service, required this.index});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
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
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.service.iconData, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 16),
            Text(widget.service.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.service.description.resolve(context),
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (100 * widget.index).ms, duration: 450.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

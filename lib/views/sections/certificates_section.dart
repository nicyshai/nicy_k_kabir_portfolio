import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/certificate_model.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/section_container.dart';
import '../../widgets/section_header.dart';

class CertificatesSection extends StatelessWidget {
  final List<CertificateModel> certificates;
  const CertificatesSection({super.key, required this.certificates});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    if (certificates.isEmpty) return const SizedBox.shrink();

    final columns = Responsive.deviceTypeOf(context) == DeviceType.mobile ? 1 : 2;

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secCertificates),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
              eyebrow: 'Certificates', title: 'Courses & certifications'),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: certificates.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 160,
            ),
            itemBuilder: (context, i) => _CertCard(cert: certificates[i], index: i),
          ),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final CertificateModel cert;
  final int index;
  const _CertCard({required this.cert, required this.index});

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
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.workspace_premium_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cert.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(cert.organization, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(cert.year,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (120 * index).ms, duration: 450.ms).slideY(begin: 0.1, end: 0);
  }
}

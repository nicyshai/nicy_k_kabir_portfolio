import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/profile_model.dart';
import '../../services/launcher_service.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/social_icons_row.dart';

class FooterSection extends StatelessWidget {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;
  const FooterSection({super.key, required this.profile, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    final isMobile = Responsive.isMobile(context);
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: 48,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.desktopContentMaxWidth),
          child: Column(
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(profile.fullName, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(profile.title, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  if (isMobile) const SizedBox(height: 24),
                  Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final item in AppConstants.navItems)
                        _FooterLink(
                          label: item.value,
                          onTap: () => nav.scrollToSection(item.key),
                        ),
                    ],
                  ),
                  if (isMobile) const SizedBox(height: 24),
                  if (!isMobile) const SizedBox(width: 24),
                  GradientButton(
                    label: 'Resume',
                    icon: Icons.download_rounded,
                    type: ButtonStyleType.outlined,
                    onPressed: () => LauncherService.openResume(profile.resumeAsset),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: 24),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '© $year ${profile.fullName}. All rights reserved.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (isMobile) const SizedBox(height: 16),
                  SocialIconsRow(
                    links: socialLinks,
                    size: 36,
                    alignment: MainAxisAlignment.center,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (b) => AppColors.brandGradient.createShader(b),
                child: const Text(
                  'Designed & built using Flutter ❤️',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

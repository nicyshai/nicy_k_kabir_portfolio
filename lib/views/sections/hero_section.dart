import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/profile_model.dart';
import '../../services/launcher_service.dart';
import '../../themes/app_theme.dart';
import '../../utils/responsive.dart';
import '../../viewmodels/navigation_view_model.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/profile_avatar.dart';
import '../../widgets/section_container.dart';
import '../../widgets/social_icons_row.dart';

class HeroSection extends StatelessWidget {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;

  const HeroSection({super.key, required this.profile, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    final isMobile = Responsive.isMobile(context);

    final content = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: Colors.greenAccent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text('Available for opportunities',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 24),
        Text(
          'Hi, I\'m ${profile.fullName}',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.displayMedium,
        ).animate().fadeIn(delay: 100.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (b) => AppColors.brandGradient.createShader(b),
          child: Text(
            profile.title,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.white, fontSize: isMobile ? 32 : 44),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            profile.summary.resolve(context),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ).animate().fadeIn(delay: 320.ms, duration: 600.ms),
        const SizedBox(height: 36),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            GradientButton(
              label: 'Contact Me',
              icon: Icons.mail_outline_rounded,
              onPressed: () => nav.scrollToSection(AppConstants.secContact),
            ),
            GradientButton(
              label: 'View Projects',
              icon: Icons.folder_open_rounded,
              type: ButtonStyleType.outlined,
              onPressed: () => nav.scrollToSection(AppConstants.secProjects),
            ),
            GradientButton(
              label: 'Download Resume',
              icon: Icons.download_rounded,
              type: ButtonStyleType.outlined,
              onPressed: () => LauncherService.openResume(profile.resumeAsset),
            ),
          ],
        ).animate().fadeIn(delay: 420.ms, duration: 600.ms),
        const SizedBox(height: 36),
        SocialIconsRow(
          links: socialLinks,
          alignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
      ],
    );

    final avatar = _FloatingAvatar(profile: profile)
        .animate()
        .fadeIn(duration: 700.ms)
        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1));

    return SectionContainer(
      sectionKey: nav.keyFor(AppConstants.secHome),
      child: isMobile
          ? Column(children: [avatar, const SizedBox(height: 40), content])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: content),
                const SizedBox(width: 48),
                Expanded(flex: 4, child: Center(child: avatar)),
              ],
            ),
    );
  }
}

class _FloatingAvatar extends StatefulWidget {
  final ProfileModel profile;
  const _FloatingAvatar({required this.profile});

  @override
  State<_FloatingAvatar> createState() => _FloatingAvatarState();
}

class _FloatingAvatarState extends State<_FloatingAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.brandCyan.withValues(alpha: 0.18),
                Colors.transparent,
              ],
            ),
          ),
        ),
        ProfileAvatar(profile: widget.profile, size: 240)
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .moveY(begin: -6, end: 6, duration: 2400.ms, curve: Curves.easeInOut),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/profile_model.dart';
import '../services/launcher_service.dart';
import '../viewmodels/navigation_view_model.dart';
import 'gradient_button.dart';
import 'social_icons_row.dart';

class AppDrawer extends StatelessWidget {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;

  const AppDrawer({super.key, required this.profile, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.fullName, style: Theme.of(context).textTheme.titleLarge),
              Text(profile.title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 32),
              for (final item in AppConstants.navItems)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.value,
                      style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    Navigator.of(context).pop();
                    Future.delayed(const Duration(milliseconds: 250),
                        () => nav.scrollToSection(item.key));
                  },
                ),
              const Spacer(),
              GradientButton(
                label: 'Download Resume',
                icon: Icons.download_rounded,
                onPressed: () => LauncherService.openResume(profile.resumeAsset),
              ),
              const SizedBox(height: 20),
              SocialIconsRow(links: socialLinks, size: 38),
            ],
          ),
        ),
      ),
    );
  }
}

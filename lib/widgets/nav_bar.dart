import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/profile_model.dart';
import '../themes/app_theme.dart';
import '../utils/responsive.dart';
import '../viewmodels/navigation_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import 'gradient_button.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileModel profile;
  final VoidCallback onOpenDrawer;

  const NavBar({super.key, required this.profile, required this.onOpenDrawer});

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationViewModel>();
    final themeVm = context.watch<ThemeViewModel>();
    final isMobile = Responsive.isMobile(context) || Responsive.isTablet(context);

    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (b) => AppColors.brandGradient.createShader(b),
            child: Text(
              profile.initials,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          if (!isMobile)
            Text(profile.fullName,
                style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          if (!isMobile) ...[
            for (final item in AppConstants.navItems)
              _NavLink(
                label: item.value,
                onTap: () => nav.scrollToSection(item.key),
              ),
            const SizedBox(width: 12),
            _ThemeToggle(isDark: themeVm.isDark, onTap: themeVm.toggle),
            const SizedBox(width: 16),
            GradientButton(
              label: 'Contact Me',
              onPressed: () => nav.scrollToSection(AppConstants.secContact),
            ),
          ] else ...[
            _ThemeToggle(isDark: themeVm.isDark, onTap: themeVm.toggle),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onOpenDrawer,
              icon: const Icon(Icons.menu_rounded),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovering
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).textTheme.bodyLarge?.color;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
                color: color, fontWeight: FontWeight.w600, fontSize: 14.5),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;
  const _ThemeToggle({required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: onTap,
      icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
    );
  }
}

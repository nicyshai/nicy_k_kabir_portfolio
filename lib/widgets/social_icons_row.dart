import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/launcher_service.dart';

class SocialIconsRow extends StatelessWidget {
  final SocialLinksModel links;
  final double size;
  final MainAxisAlignment alignment;

  const SocialIconsRow({
    super.key,
    required this.links,
    this.size = 40,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final entries = <MapEntry<IconData, String>>[];
    if (links.github != null) entries.add(MapEntry(Icons.code_rounded, links.github!));
    if (links.linkedin != null) {
      entries.add(MapEntry(Icons.business_center_rounded, links.linkedin!));
    }
    if (links.twitter != null) entries.add(MapEntry(Icons.alternate_email_rounded, links.twitter!));
    if (links.instagram != null) {
      entries.add(MapEntry(Icons.camera_alt_rounded, links.instagram!));
    }
    if (links.portfolio != null) {
      entries.add(MapEntry(Icons.public_rounded, links.portfolio!));
    }

    if (entries.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: entries
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _SocialButton(
                  icon: e.key,
                  size: size,
                  onTap: () => LauncherService.open(e.value),
                ),
              ))
          .toList(),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.size, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovering
                ? scheme.primary.withValues(alpha: 0.18)
                : scheme.surface,
            border: Border.all(
              color: _hovering ? scheme.primary : Theme.of(context).dividerColor,
            ),
          ),
          child: Icon(widget.icon,
              size: widget.size * 0.42,
              color: _hovering ? scheme.primary : Theme.of(context).textTheme.bodyMedium?.color),
        ),
      ),
    );
  }
}

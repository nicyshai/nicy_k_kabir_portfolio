import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/profile_model.dart';
import '../themes/app_theme.dart';

/// Shows the resume-provided profile photo if one exists; otherwise
/// falls back to a tasteful gradient initials avatar rather than
/// inventing or guessing a photo.
class ProfileAvatar extends StatelessWidget {
  final ProfileModel profile;
  final double size;

  const ProfileAvatar({super.key, required this.profile, this.size = 220});

  @override
  Widget build(BuildContext context) {
    final image = profile.profileImage;
    Widget? imageWidget;

    if (image != null) {
      if (image.startsWith('http')) {
        imageWidget = CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => _initials(context),
        );
      } else {
        imageWidget = Image.asset(
          image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _initials(context),
        );
      }
    }

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.brandGradient,
      ),
      child: ClipOval(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: imageWidget ?? _initials(context),
        ),
      ),
    );
  }

  Widget _initials(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) => AppColors.brandGradient.createShader(bounds),
        child: Text(
          profile.initials,
          style: TextStyle(
            fontSize: size * 0.34,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

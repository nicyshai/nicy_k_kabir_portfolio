import 'responsive_value.dart';

class ProfileModel {
  final String fullName;
  final String title;
  final String subtitle;
  final ResponsiveValue<String> summary;
  final String email;
  final String phone;
  final String location;
  final String? profileImage;
  final String resumeAsset;

  const ProfileModel({
    required this.fullName,
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.email,
    required this.phone,
    required this.location,
    required this.resumeAsset,
    this.profileImage,
  });

  /// Returns the initials to use for the placeholder avatar,
  /// e.g. "Nicy K Kabir" -> "NK".
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      summary: ResponsiveValue.fromJson(json['summary'], (v) => v.toString()),
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      profileImage: json['profileImage'],
      resumeAsset: json['resumeAsset'] ?? '',
    );
  }
}

class SocialLinksModel {
  final String? github;
  final String? linkedin;
  final String? portfolio;
  final String? twitter;
  final String? instagram;
  final String? whatsapp;

  const SocialLinksModel({
    this.github,
    this.linkedin,
    this.portfolio,
    this.twitter,
    this.instagram,
    this.whatsapp,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) {
    return SocialLinksModel(
      github: json['github'],
      linkedin: json['linkedin'],
      portfolio: json['portfolio'],
      twitter: json['twitter'],
      instagram: json['instagram'],
      whatsapp: json['whatsapp'],
    );
  }
}

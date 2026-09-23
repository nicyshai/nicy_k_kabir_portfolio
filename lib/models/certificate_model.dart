import 'responsive_value.dart';

class CertificateModel {
  final String title;
  final String organization;
  final String year;

  const CertificateModel({
    required this.title,
    required this.organization,
    required this.year,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      year: json['year'] ?? '',
    );
  }
}

class AchievementModel {
  final String title;
  final ResponsiveValue<String> description;

  const AchievementModel({required this.title, required this.description});

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      title: json['title'] ?? '',
      description: ResponsiveValue.fromJson(json['description'], (v) => v.toString()),
    );
  }
}

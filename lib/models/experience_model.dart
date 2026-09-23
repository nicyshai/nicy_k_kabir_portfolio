class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final List<String> responsibilities;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.responsibilities,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      duration: json['duration'] ?? '',
      responsibilities:
          List<String>.from(json['responsibilities'] ?? const []),
    );
  }
}

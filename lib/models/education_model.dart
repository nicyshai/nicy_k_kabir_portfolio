class EducationModel {
  final String degree;
  final String institution;
  final String duration;

  const EducationModel({
    required this.degree,
    required this.institution,
    required this.duration,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      degree: json['degree'] ?? '',
      institution: json['institution'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}

import 'profile_model.dart';
import 'skill_model.dart';
import 'project_model.dart';
import 'experience_model.dart';
import 'education_model.dart';
import 'certificate_model.dart';
import 'service_model.dart';

/// Aggregate root loaded from assets/data/portfolio_data.json.
/// No personal information is ever hardcoded in the app -- everything
/// flows through this model.
class PortfolioData {
  final ProfileModel profile;
  final SocialLinksModel socialLinks;
  final List<SkillCategoryModel> skills;
  final List<ProjectModel> projects;
  final List<ExperienceModel> experience;
  final List<EducationModel> education;
  final List<CertificateModel> certificates;
  final List<AchievementModel> achievements;
  final List<ServiceModel> services;

  const PortfolioData({
    required this.profile,
    required this.socialLinks,
    required this.skills,
    required this.projects,
    required this.experience,
    required this.education,
    required this.certificates,
    required this.achievements,
    required this.services,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      profile: ProfileModel.fromJson(json['profile'] ?? {}),
      socialLinks: SocialLinksModel.fromJson(json['socialLinks'] ?? {}),
      skills: (json['skills'] as List? ?? [])
          .map((e) => SkillCategoryModel.fromJson(e))
          .toList(),
      projects: (json['projects'] as List? ?? [])
          .map((e) => ProjectModel.fromJson(e))
          .toList(),
      experience: (json['experience'] as List? ?? [])
          .map((e) => ExperienceModel.fromJson(e))
          .toList(),
      education: (json['education'] as List? ?? [])
          .map((e) => EducationModel.fromJson(e))
          .toList(),
      certificates: (json['certificates'] as List? ?? [])
          .map((e) => CertificateModel.fromJson(e))
          .toList(),
      achievements: (json['achievements'] as List? ?? [])
          .map((e) => AchievementModel.fromJson(e))
          .toList(),
      services: (json['services'] as List? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }
}

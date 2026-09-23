import 'responsive_value.dart';

class ProjectModel {
  final String name;
  final ResponsiveValue<String> description;
  final List<String> technologies;
  final List<String> features;
  final String? github;
  final String? liveDemo;
  final String? apk;
  final String? image;

  const ProjectModel({
    required this.name,
    required this.description,
    required this.technologies,
    required this.features,
    this.github,
    this.liveDemo,
    this.apk,
    this.image,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'] ?? '',
      description: ResponsiveValue.fromJson(json['description'], (v) => v.toString()),
      technologies: List<String>.from(json['technologies'] ?? const []),
      features: List<String>.from(json['features'] ?? const []),
      github: json['github'],
      liveDemo: json['liveDemo'],
      apk: json['apk'],
      image: json['image'],
    );
  }
}

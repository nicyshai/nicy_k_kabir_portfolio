class SkillCategoryModel {
  final String category;
  final List<String> items;

  const SkillCategoryModel({required this.category, required this.items});

  factory SkillCategoryModel.fromJson(Map<String, dynamic> json) {
    return SkillCategoryModel(
      category: json['category'] ?? '',
      items: List<String>.from(json['items'] ?? const []),
    );
  }
}

import 'package:flutter/material.dart';
import 'responsive_value.dart';

class ServiceModel {
  final String title;
  final ResponsiveValue<String> description;
  final String icon;

  const ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      title: json['title'] ?? '',
      description: ResponsiveValue.fromJson(json['description'], (v) => v.toString()),
      icon: json['icon'] ?? 'star',
    );
  }

  /// Maps the string icon key stored in JSON to a Material icon.
  IconData get iconData {
    switch (icon) {
      case 'phone_iphone':
        return Icons.phone_iphone_rounded;
      case 'cloud_sync':
        return Icons.cloud_sync_rounded;
      case 'architecture':
        return Icons.architecture_rounded;
      case 'design_services':
        return Icons.design_services_rounded;
      case 'hub':
        return Icons.hub_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}

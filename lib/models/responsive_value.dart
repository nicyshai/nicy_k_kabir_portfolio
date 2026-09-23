import 'package:flutter/widgets.dart';
import '../utils/responsive.dart';

/// A utility to hold values that change based on screen size.
/// Can be initialized with a single value for all sizes, or
/// specific values for mobile, tablet, and desktop.
class ResponsiveValue<T> {
  final T desktop;
  final T? tablet;
  final T? mobile;

  const ResponsiveValue({
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  /// Resolves the value based on the current context.
  T resolve(BuildContext context) {
    final type = Responsive.deviceTypeOf(context);
    switch (type) {
      case DeviceType.mobile:
        return mobile ?? tablet ?? desktop;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Parses from JSON which can be either a raw value or a map.
  factory ResponsiveValue.fromJson(dynamic json, T Function(dynamic) parser) {
    if (json is Map && (json.containsKey('desktop') || json.containsKey('mobile'))) {
      return ResponsiveValue(
        desktop: parser(json['desktop'] ?? json['mobile']),
        tablet: json.containsKey('tablet') ? parser(json['tablet']) : null,
        mobile: json.containsKey('mobile') ? parser(json['mobile']) : null,
      );
    }
    final value = parser(json);
    return ResponsiveValue(desktop: value);
  }
}

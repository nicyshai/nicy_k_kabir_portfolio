import 'package:flutter/widgets.dart';
import '../constants/app_constants.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static DeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileMaxWidth) return DeviceType.mobile;
    if (width < AppConstants.tabletMaxWidth) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.desktop;

  /// Number of columns for the responsive project grid.
  static int projectGridColumns(BuildContext context) {
    switch (deviceTypeOf(context)) {
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
    }
  }

  /// Horizontal padding that scales down on smaller screens.
  static double horizontalPadding(BuildContext context) {
    switch (deviceTypeOf(context)) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.tablet:
        return 40;
      case DeviceType.desktop:
        return 72;
    }
  }
}

/// Generic responsive switcher widget, used when three fully distinct
/// layouts are needed rather than just column-count changes.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final type = Responsive.deviceTypeOf(context);
    if (type == DeviceType.mobile) return mobile;
    if (type == DeviceType.tablet) return tablet ?? desktop;
    return desktop;
  }
}

class AppConstants {
  AppConstants._();

  // Responsive breakpoints
  static const double mobileMaxWidth = 640;
  static const double tabletMaxWidth = 1024;
  static const double desktopContentMaxWidth = 1180;

  // Section keys used for scroll-to-section navigation
  static const String secHome = 'home';
  static const String secAbout = 'about';
  static const String secSkills = 'skills';
  static const String secProjects = 'projects';
  static const String secExperience = 'experience';
  static const String secEducation = 'education';
  static const String secCertificates = 'certificates';
  static const String secServices = 'services';
  static const String secContact = 'contact';

  static const List<MapEntry<String, String>> navItems = [
    MapEntry(secHome, 'Home'),
    MapEntry(secAbout, 'About'),
    MapEntry(secSkills, 'Skills'),
    MapEntry(secProjects, 'Projects'),
    MapEntry(secExperience, 'Experience'),
    MapEntry(secServices, 'Services'),
    MapEntry(secContact, 'Contact'),
  ];
}

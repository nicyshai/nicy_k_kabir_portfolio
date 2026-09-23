import 'package:url_launcher/url_launcher.dart';

/// Central place for every outbound link (mail, tel, social, resume).
/// Centralizing this keeps view code declarative -- widgets just call
/// LauncherService.open(url) and never touch the platform API directly.
class LauncherService {
  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Fallback: try the platform default mode.
      await launchUrl(uri);
    }
  }

  static Future<void> openEmail(String email, {String? subject}) async {
    final query = subject != null ? '?subject=${Uri.encodeComponent(subject)}' : '';
    await open('mailto:$email$query');
  }

  static Future<void> openPhone(String phone) async {
    await open('tel:$phone');
  }

  static Future<void> openWhatsApp(String phone) async {
    final sanitized = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    await open('https://wa.me/$sanitized');
  }

  static Future<void> openResume(String assetPath) async {
    // On Flutter Web, bundled assets are served relative to the app's
    // own origin under an `assets/` prefix. Resolving against Uri.base
    // gives the correct absolute URL so the browser can open/download it.
    final resolved = Uri.base.resolve('assets/$assetPath');
    await open(resolved.toString());
  }
}

import 'package:flutter/material.dart';

/// Manages the single page's scroll controller, per-section keys used
/// for "scroll to section" navigation, and the visibility of the
/// "back to top" button.
class NavigationViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {};

  bool _showBackToTop = false;
  bool get showBackToTop => _showBackToTop;

  NavigationViewModel() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow = scrollController.offset > 480;
    if (shouldShow != _showBackToTop) {
      _showBackToTop = shouldShow;
      notifyListeners();
    }
  }

  GlobalKey keyFor(String sectionId) {
    return sectionKeys.putIfAbsent(sectionId, () => GlobalKey());
  }

  void scrollToSection(String sectionId) {
    final key = sectionKeys[sectionId];
    final context = key?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}

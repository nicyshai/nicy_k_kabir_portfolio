import 'package:go_router/go_router.dart';
import '../views/portfolio_screen.dart';

/// Single-page portfolio: all in-page navigation is handled via
/// scroll-to-section rather than route changes, but GoRouter is kept
/// as the app's router so deep-linking (e.g. /#/  ) and future
/// multi-page expansion (blog, project detail pages) stay trivial.
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PortfolioScreen(),
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/portfolio_data.dart';
import '../themes/app_theme.dart';
import '../viewmodels/navigation_view_model.dart';
import '../viewmodels/portfolio_view_model.dart';
import '../widgets/app_drawer.dart';
import '../widgets/back_to_top_button.dart';
import '../widgets/nav_bar.dart';
import 'sections/about_section.dart';
import 'sections/achievements_section.dart';
import 'sections/certificates_section.dart';
import 'sections/contact_section.dart';
import 'sections/education_section.dart';
import 'sections/experience_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/services_section.dart';
import 'sections/skills_section.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PortfolioViewModel>();

    switch (vm.status) {
      case LoadStatus.loading:
        return const _LoadingView();
      case LoadStatus.error:
        return _ErrorView(message: vm.error ?? 'Something went wrong.', onRetry: vm.retry);
      case LoadStatus.success:
        return _PortfolioContent(data: vm.data!);
    }
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.brandCyan),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.accentAmber),
              const SizedBox(height: 16),
              Text('Couldn\'t load portfolio data', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioContent extends StatefulWidget {
  final PortfolioData data;
  const _PortfolioContent({required this.data});

  @override
  State<_PortfolioContent> createState() => _PortfolioContentState();
}

class _PortfolioContentState extends State<_PortfolioContent> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final nav = context.watch<NavigationViewModel>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(profile: data.profile, socialLinks: data.socialLinks),
      appBar: NavBar(
        profile: data.profile,
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: nav.scrollController,
            child: Column(
              children: [
                HeroSection(profile: data.profile, socialLinks: data.socialLinks),
                AboutSection(profile: data.profile),
                SkillsSection(skills: data.skills),
                ProjectsSection(projects: data.projects),
                ExperienceSection(experience: data.experience),
                EducationSection(education: data.education),
                CertificatesSection(certificates: data.certificates),
                AchievementsSection(achievements: data.achievements),
                ServicesSection(services: data.services),
                ContactSection(profile: data.profile, socialLinks: data.socialLinks),
                FooterSection(profile: data.profile, socialLinks: data.socialLinks),
              ],
            ),
          ),
          const BackToTopButton(),
        ],
      ),
    );
  }
}

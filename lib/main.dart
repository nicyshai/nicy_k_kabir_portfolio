import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';
import 'viewmodels/navigation_view_model.dart';
import 'viewmodels/portfolio_view_model.dart';
import 'viewmodels/theme_view_model.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PortfolioViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeVm, _) {
          return MaterialApp.router(
            title: 'Nicy K Kabir | Flutter Developer Portfolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeVm.mode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}

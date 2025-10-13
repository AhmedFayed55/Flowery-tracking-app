import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/thanks_page.dart';
import 'package:flutter/material.dart';

import '../../features/main_layout/main_layout.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());

      case AppRoutes.thanksPage:
        return MaterialPageRoute(builder: (context) => const ThanksPage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}

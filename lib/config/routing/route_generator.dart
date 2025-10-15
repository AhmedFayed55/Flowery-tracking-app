import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/pages/apply_screen.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/pages/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di.dart';
import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import '../../features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/main_profile/presentation/pages/main_profile.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const ApplyScreen());

      case AppRoutes.mainProfile:
        return MaterialPageRoute(builder: (context) => const MainProfile());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoutes.ordersPage:
        return MaterialPageRoute(builder: (context) => OrdersPage());

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

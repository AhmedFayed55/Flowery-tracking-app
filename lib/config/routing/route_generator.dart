import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/pages/apply_screen.dart';
import 'package:flowery_tracking_app/features/application_approved/presentation/pages/application_approved_screen.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/page/change_password_screen.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/auth/onboarding/onboarding.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/order_details_screen.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/pages/edit_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/main_layout/main_layout.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());
      case AppRoutes.orderDetails:
        return MaterialPageRoute(builder: (context) => OrderDetailsScreen());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoutes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const ApplyScreen());

      case AppRoutes.applicationApproved:
        return MaterialPageRoute(
          builder: (context) => const ApplicationApprovedScreen(),
        );

      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case AppRoutes.updateVehicle:
        return MaterialPageRoute(
          builder: (context) => const EditVehicleScreen(), 
        );
      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );

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

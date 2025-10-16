import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/page/change_password_screen.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/pages/apply_screen.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/thanks_page.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/pages/orders_page.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/order_details_screen.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_cubit.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/pick_up_location.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/pages/edit_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import '../../features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/main_profile/presentation/pages/main_profile.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());
      case AppRoutes.orderDetails:
        return MaterialPageRoute(builder: (context) => OrderDetailsScreen());
      case AppRoutes.login : 
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.thanksPage:
        final orderId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ThanksPage(orderId: orderId),
        );

      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );

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
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case AppRoutes.updateVehicle:
        return MaterialPageRoute(
          builder: (context) => const EditVehicleScreen(),
        );

      case AppRoutes.ordersPage:
        return MaterialPageRoute(builder: (context) => OrdersPage());

      case AppRoutes.pickupLocation:
        final args = settings.arguments as Map<String, dynamic>;
        final storeEntity = args['store'] as StoreEntity;
        final userEntity = args['user'] as UserEntity;
        var pickUpLocationViewModel = getIt.get<PickUpCubit>();

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => pickUpLocationViewModel,
            child: PickUpLocationPage(store: storeEntity, user: userEntity),
          ),
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

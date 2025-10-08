import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_cubit.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/pick_up_location.dart';
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
      case AppRoutes.pickupLocation:
        // var user  = (settings.arguments as Map<String, dynamic>)['user'] as UserEntity;
        // var stor = (settings.arguments as Map<String, dynamic>)['store'] as StoreEntity;
        var pickUpLocationViewModel = getIt.get<PickUpCubit>();
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => pickUpLocationViewModel,
            child: PickUpLocationPage(
              user: UserEntity(
                id: '1',
                lastName: 'Yehia',
                firstName: 'Ahmed',
                email: '2Tm5o@example.com',
                phone: '0123456789',
                photo: 'default.png',
                gender: 'male',
              ),
              store: StoreEntity(
                address: "Cairo, Egypt",
                image: 'default.png',
                phoneNumber: '0123456789',
                name: 'Store 1',
                latLong: "31.000000, 30.000000",
              ),
            ),
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

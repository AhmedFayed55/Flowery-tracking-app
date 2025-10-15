import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'app_routes.dart';

String? getInitialRoute() {
  final isRemember = getIt<SharedPrefHelper>().getData(
    key: AppConstants.isRemember,
  );
  if (isRemember == false || isRemember == null) {
    return AppRoutes.mainProfile;
  } else {
    return AppRoutes.mainLayout;
  }
}

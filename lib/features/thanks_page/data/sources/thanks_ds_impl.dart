import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/thanks_page/data/sources/thanks_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ThanksDs)
class ThanksDsImpl implements ThanksDs {
  final ApiServices _apiServices;
  final SharedPrefHelper _sharedPrefHelper;
  ThanksDsImpl(this._apiServices, this._sharedPrefHelper);
  @override
  Future<void> updateOrderStatusApi(String orderId, OrderStatus status) {
    return _apiServices.updateOrderStatusApi(orderId, {
      ApiConstants.state: status.statusText,
    });
  }

  @override
  Future<void> deleteOrderLocal() async {
    await _sharedPrefHelper.removeData(key: AppConstants.orderId);
  }
}

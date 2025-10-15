import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/thanks_page/data/sources/thanks_ds.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/repo/thanks_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: ThanksRepo)
class ThanksRepoImpl implements ThanksRepo {
  final ThanksDs _thanksDs;
  final InternetConnectionChecker _internetConnectionChecker;
  ThanksRepoImpl(this._thanksDs, this._internetConnectionChecker);

  @override
  Future<ApiResult> updateOrderStatusApi(
    String orderId,
    OrderStatus status,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return ApiErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }
    return safeApiCall(() => _thanksDs.updateOrderStatusApi(orderId, status));
  }

  @override
  Future<void> deleteOrderLocal() async => _thanksDs.deleteOrderLocal();
}

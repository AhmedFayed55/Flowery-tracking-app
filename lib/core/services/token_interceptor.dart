import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/services/token_service.dart';
import 'package:injectable/injectable.dart';
import '../di/di.dart';
import '../utils/constants.dart';

@injectable
class TokenInterceptor extends Interceptor {
  final TokenService tokenService = getIt.get<TokenService>();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await tokenService.getToken();
    if (token != null) {
      options.headers[AppConstants.authorization] =
          "${AppConstants.bearer} $token";
    }
    return super.onRequest(options, handler);
  }
}

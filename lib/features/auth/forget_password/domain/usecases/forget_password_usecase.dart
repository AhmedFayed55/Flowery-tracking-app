import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/repositories/Forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUsecase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ForgetPasswordUsecase(this._forgetPasswordRepo);

  Future<ApiResult<ForgetPasswordRespone>> invoke(
    ForgotPasswordRequest body,
  ) async {
    return await _forgetPasswordRepo.forgotPassword(body);
  }
}

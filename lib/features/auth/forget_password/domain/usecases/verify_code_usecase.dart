import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/repositories/Forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyCodeUsecase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  VerifyCodeUsecase(this._forgetPasswordRepo);
  Future<ApiResult<VerifyPasswordRespone>> invoke(
    VerifyPasswordBody body,
  ) async {
    return await _forgetPasswordRepo.verifyCode(body);
  }
}

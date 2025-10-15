import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUsecase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ResetPasswordUsecase(this._forgetPasswordRepo);
  Future<ApiResult<ResetPasswordRespone>> invoke(ResetPasswordBody body) async {
    return await _forgetPasswordRepo.resetPassword(body);
  }
}

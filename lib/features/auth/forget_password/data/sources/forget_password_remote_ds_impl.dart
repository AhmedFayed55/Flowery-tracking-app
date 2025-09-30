import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/sources/forget_password_remote_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRemoteDS)
class ForgetPasswordRemoteDsImpl implements ForgetPasswordRemoteDS {
  final ApiServices _apiServices;

  ForgetPasswordRemoteDsImpl(this._apiServices);

  @override
  Future<ForgetPasswordRespone> forgotPassword(
    ForgotPasswordRequest body,
  ) async {
    return await _apiServices.forgotPassword(body);
  }

  @override
  Future<ResetPasswordRespone> resetPassword(ResetPasswordBody body) async {
    return await _apiServices.resetPassword(body);
  }

  @override
  Future<VerifyPasswordRespone> verifyCode(VerifyPasswordBody body) async {
    return await _apiServices.verifyCode(body);
  }
}

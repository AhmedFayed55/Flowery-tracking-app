import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';

abstract interface class ForgetPasswordRemoteDS {
  Future<ForgetPasswordRespone> forgotPassword(ForgotPasswordRequest body);
  Future<VerifyPasswordRespone> verifyCode(VerifyPasswordBody body);
  Future<ResetPasswordRespone> resetPassword(ResetPasswordBody body);
}

import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiServices apiServices;

  LoginRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    var loginResponseModel = await apiServices.login({
      "email": email,
      "password": password,
    });
    return loginResponseModel;
  }
}

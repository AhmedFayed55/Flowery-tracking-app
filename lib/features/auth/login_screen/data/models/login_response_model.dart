import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  LoginResponseModel({this.message, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseModelToJson(this);
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(message: message, token: token);
  }
}

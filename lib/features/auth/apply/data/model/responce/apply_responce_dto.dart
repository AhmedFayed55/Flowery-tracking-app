import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/driver_model_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part'apply_responce_dto.g.dart';
@JsonSerializable()
class ApplyResponceDto {
  final String message;
  final DriverModelDto driver;
  final String token;

  ApplyResponceDto({
    required this.message,
    required this.driver,
    required this.token,
  });

  factory ApplyResponceDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponceDtoToJson(this);
}

import 'package:flowery_tracking_app/features/edit_profile/data/models/driver_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_logged_driver_response_dto.g.dart';

@JsonSerializable()
class GetLoggedDriverResponseDto {
  final String message;
  final DriverDto driver;

  GetLoggedDriverResponseDto({required this.message, required this.driver});

  factory GetLoggedDriverResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetLoggedDriverResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoggedDriverResponseDtoToJson(this);
}

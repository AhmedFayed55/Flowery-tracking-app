import 'package:flowery_tracking_app/features/edit_profile/data/data/models/driver_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_dto.g.dart';

@JsonSerializable()
class EditProfileResponseDto {
  final String message;
  final DriverDto driver;

  EditProfileResponseDto({required this.message, required this.driver});

  factory EditProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseDtoToJson(this);
}

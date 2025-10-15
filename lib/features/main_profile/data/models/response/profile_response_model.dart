import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final DriverDto? driverDto;

  ProfileResponseModel({this.message, this.driverDto});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseModelToJson(this);
  }

  ProfileResponseEntity toEntity() {
    return ProfileResponseEntity(
      message: message,
      driverDtoEntity: driverDto?.toEntity(),
    );
  }
}

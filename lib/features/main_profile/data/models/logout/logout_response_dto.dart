import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_response_dto.g.dart';

@JsonSerializable()
class LogoutResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "error")
  final String? error;

  LogoutResponseDto ({
    this.message,
    this.error,
  });

  factory LogoutResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LogoutResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoutResponseDtoToJson(this);
  }

  LogoutResponseEntity toEntity(){
    return LogoutResponseEntity(
      message: message,
      error: error
    );
  }
}



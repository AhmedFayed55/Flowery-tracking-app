import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logged_driver_data.g.dart';

@JsonSerializable()
class LoggedDriverDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final DriverDataDto? driver;

  LoggedDriverDto ({
    this.message,
    this.driver,
  });

  factory LoggedDriverDto.fromJson(Map<String, dynamic> json) {
    return _$LoggedDriverDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoggedDriverDtoToJson(this);
  }
}





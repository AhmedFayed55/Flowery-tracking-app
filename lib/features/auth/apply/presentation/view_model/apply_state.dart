import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';

class ApplyState {
  bool isLoading;
  String errorMessage;
  DriverEntity? driver;
  List<VehicelEntity>? vehicelEntity;
  ApplyState({
    this.isLoading = false,
    this.errorMessage = '',
    this.driver,
    this.vehicelEntity,
  });
  ApplyState copyWith({
    bool? isLoading,
    String? errorMessage,
    DriverEntity? driver,
    List<VehicelEntity>? vehicelEntity,
  }) {
    return ApplyState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      driver: driver ?? this.driver,
      vehicelEntity: vehicelEntity ?? this.vehicelEntity,
    );
  }
}

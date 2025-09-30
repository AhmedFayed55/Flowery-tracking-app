import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';

sealed class ApplyEvent {}

class ApplyDriverEvent extends ApplyEvent {
  RequestApplyEntity requestEntity;
  ApplyDriverEvent(this.requestEntity);
}  
class GetVehiclesEvent extends ApplyEvent {}
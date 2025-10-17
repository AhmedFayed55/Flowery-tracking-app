import 'package:latlong2/latlong.dart';

abstract class PickUpEvent {}

class InitializeMapEvent extends PickUpEvent {
  final LatLng destination;
  InitializeMapEvent(this.destination);
}

class GetRouteEvent extends PickUpEvent {
  final LatLng destination;
  GetRouteEvent(this.destination);
}

class ResetEvent extends PickUpEvent {}

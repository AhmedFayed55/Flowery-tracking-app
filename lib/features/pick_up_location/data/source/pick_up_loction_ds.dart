import 'package:latlong2/latlong.dart';

abstract interface class PickUpLoctionDs {
  Future<List<LatLng>> getRoute(LatLng start, LatLng dest);
}

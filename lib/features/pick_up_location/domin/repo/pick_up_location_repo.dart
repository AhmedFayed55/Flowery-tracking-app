import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:latlong2/latlong.dart';

abstract interface class PickUpLocationRepo {
  Future<ApiResult<List<LatLng>>> getRoute(LatLng start, LatLng dest);
}

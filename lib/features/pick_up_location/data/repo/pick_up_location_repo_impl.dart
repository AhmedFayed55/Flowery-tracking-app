import 'package:flowery_tracking_app/features/pick_up_location/data/source/pick_up_loction_ds.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/pick_up_location/domin/repo/pick_up_location_repo.dart';
import 'package:latlong2/latlong.dart';

@Injectable(as: PickUpLocationRepo)
class PickUpLocationRepoImpl implements PickUpLocationRepo {
  final PickUpLoctionDs pickUpLoctionDs;
  PickUpLocationRepoImpl(this.pickUpLoctionDs);
  @override
  Future<ApiResult<List<LatLng>>> getRoute(LatLng start, LatLng dest) {
    return safeApiCall(() => pickUpLoctionDs.getRoute(start, dest));
  }
}

import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/pick_up_location/domin/repo/pick_up_location_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class GetRoutesUsecase {
  final PickUpLocationRepo pickUpLocationRepo;

  GetRoutesUsecase(this.pickUpLocationRepo);

  Future<ApiResult<List<LatLng>>> call(LatLng start, LatLng dest) {
    return pickUpLocationRepo.getRoute(start, dest);
  }
}

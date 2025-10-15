import 'dart:convert';

import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/pick_up_location/data/source/pick_up_loction_ds.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

@Injectable(as: PickUpLoctionDs)
class PickUpLocationDsImpl implements PickUpLoctionDs {
  final String orsApiKey = dotenv.env['ORS_API_KEY'] ?? '';

  PickUpLocationDsImpl();

  @override
  Future<List<LatLng>> getRoute(LatLng start, LatLng dest) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.mapUrl}$orsApiKey'
        '&start=${start.longitude},${start.latitude}'
        '&end=${dest.longitude},${dest.latitude}',
      ),
    );

    var data = jsonDecode(response.body);
    final List<dynamic> coords =
        data[ApiConstants.features][0][ApiConstants.geometry][ApiConstants
            .coordinates];
    final points = coords.map((e) => LatLng(e[1], e[0])).toList();

    return points;
  }
}

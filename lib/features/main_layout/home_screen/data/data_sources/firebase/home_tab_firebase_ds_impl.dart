import 'package:flowery_tracking_app/core/services/firebase_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/to_firebase/to_firebase_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeTabFirebaseDataSource)
class HomeTabFirebaseDataSourceImpl implements HomeTabFirebaseDataSource{
  final FirebaseService _service;
  HomeTabFirebaseDataSourceImpl(this._service);

  @override
  Future<void> saveOrder(ToFirebaseDto model) async{
    await _service.addData(
      AppConstants.ordersCollection,
      model.orders!.id!,
      model.toJson(),
    );
  }

}
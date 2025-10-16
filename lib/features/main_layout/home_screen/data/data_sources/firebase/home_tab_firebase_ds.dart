import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/to_firebase/to_firebase_dto.dart';

abstract interface class HomeTabFirebaseDataSource {
  Future<void> saveOrder(ToFirebaseDto model);
}

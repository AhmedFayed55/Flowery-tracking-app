import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:latlong2/latlong.dart';

class ToFirebaseEntity {
  ToFirebaseEntity({
    this.orders,
    this.driverLocation,
    this.driverData,
    this.userState,
  });

  String? userState;
  LatLng? driverLocation;
  OrdersEntity? orders;
  DriverDataEntity? driverData;
}

import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/metadata_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';

class GetPendingOrdersEntity {
  GetPendingOrdersEntity({this.message, this.metadata, this.orders});

  String? message;
  MetadataEntity? metadata;
  List<OrdersEntity>? orders;
}

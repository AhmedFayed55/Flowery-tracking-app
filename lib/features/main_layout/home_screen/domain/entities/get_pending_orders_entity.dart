import 'metadata_entity.dart';
import 'orders_entity.dart';

class GetPendingOrdersEntity {
  GetPendingOrdersEntity({
      this.message, 
      this.metadata, 
      this.orders,});

  String? message;
  MetadataEntity? metadata;
  List<OrdersEntity>? orders;

}
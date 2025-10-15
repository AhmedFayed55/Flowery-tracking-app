import 'metadata_dto_entity.dart';
import 'orders_dto_entity.dart';

class GetAllOrdersEntity {
  final String? message;
  final MetadataDtoEntity? metadataDtoEntity;
  final List<OrdersDtoEntity>? ordersDtoEntity;

  GetAllOrdersEntity({
    this.message,
    this.metadataDtoEntity,
    this.ordersDtoEntity,
  });
}

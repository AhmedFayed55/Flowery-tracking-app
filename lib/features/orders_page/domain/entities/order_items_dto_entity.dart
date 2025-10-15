import 'package:flowery_tracking_app/features/orders_page/domain/entities/product_dto_entity.dart';

class OrderItemsDtoEntity {
  final ProductDtoEntity? productDtoEntity;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemsDtoEntity({
    this.productDtoEntity,
    this.price,
    this.quantity,
    this.id,
  });
}

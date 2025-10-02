import 'product_entity.dart';

class OrderItemsEntity {
  OrderItemsEntity({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  ProductEntity? product;
  num? price;
  num? quantity;
  String? id;

  Map<String, dynamic> toJson() => {
    "product": product,
    "price": price,
    "quantity": quantity,
    "_id": id,
  };
}
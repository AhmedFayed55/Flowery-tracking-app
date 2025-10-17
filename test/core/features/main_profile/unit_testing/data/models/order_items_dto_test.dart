import 'package:flowery_tracking_app/features/orders_page/data/models/order_items_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test OrderItemsDto to OrderItemsDtoEntity", () {
    // Arrange
    final orderItemsDto = OrderItemsDto(price: 1, quantity: 1, id: "1");

    // Act
    final result = orderItemsDto.toEntity();

    // Assert
    expect(result.id, equals(orderItemsDto.id));
    expect(result.price, equals(orderItemsDto.price));
    expect(result.quantity, equals(orderItemsDto.quantity));
    expect(result.productDtoEntity?.id, equals(orderItemsDto.productDto?.id));
    expect(
      result.productDtoEntity?.price,
      equals(orderItemsDto.productDto?.price),
    );
  });
}

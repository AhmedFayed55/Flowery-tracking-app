import 'package:flowery_tracking_app/features/orders_page/data/models/order_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test OrderDto to OrderDtoEntity", () {
    // Arrange
    final orderDto = OrderDto(
      id: "order1",
      totalPrice: 1,
      paymentType: "paymentType",
      isPaid: true,
      isDelivered: false,
      state: "state",
      createdAt: "createdAt",
      updatedAt: "updatedAt",
      orderNumber: "orderNumber",
      V: 1,
    );

    // Act
    final result = orderDto.toEntity();

    // Assert
    expect(result.id, equals(orderDto.id));
    expect(result.userDtoEntity?.id, equals(orderDto.userDto?.id));
    expect(result.userDtoEntity?.email, equals(orderDto.userDto?.email));

    expect(
      result.orderItemsDtoEntity?.length,
      equals(orderDto.orderItemsDto?.length),
    );
    expect(
      result.orderItemsDtoEntity?.first.id,
      equals(orderDto.orderItemsDto?.first.id),
    );
    expect(
      result.orderItemsDtoEntity?.first.price,
      equals(orderDto.orderItemsDto?.first.price),
    );
    expect(
      result.orderItemsDtoEntity?.first.quantity,
      equals(orderDto.orderItemsDto?.first.quantity),
    );

    expect(result.totalPrice, equals(orderDto.totalPrice));
    expect(result.paymentType, equals(orderDto.paymentType));
    expect(result.isPaid, equals(orderDto.isPaid));
    expect(result.isDelivered, equals(orderDto.isDelivered));
    expect(result.state, equals(orderDto.state));
    expect(result.createdAt, equals(orderDto.createdAt));
    expect(result.updatedAt, equals(orderDto.updatedAt));
    expect(result.orderNumber, equals(orderDto.orderNumber));
    expect(result.V, equals(orderDto.V));
  });
}

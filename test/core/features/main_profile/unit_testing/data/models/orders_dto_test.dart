import 'package:flowery_tracking_app/features/orders_page/data/models/orders_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test OrdersDto to OrdersDtoEntity", () {
    // Arrange

    final ordersDto = OrdersDto(
      id: "id",
      driver: "driver",
      V: 1,
      createdAt: "createdAt",
      updatedAt: "updatedAt",
    );

    // Act
    final result = ordersDto.toEntity();

    // Assert
    expect(result.id, equals(ordersDto.id));
    expect(result.driver, equals(ordersDto.driver));
    expect(result.V, equals(ordersDto.V));
    expect(result.createdAt, equals(ordersDto.createdAt));
    expect(result.updatedAt, equals(ordersDto.updatedAt));
  });
}

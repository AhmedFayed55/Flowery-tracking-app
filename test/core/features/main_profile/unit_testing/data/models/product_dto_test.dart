import 'package:flowery_tracking_app/features/orders_page/data/models/product_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test ProductDto to ProductDtoEntity", () {
    // Arrange
    final productDto = ProductDto(id: "_d", price: 1);

    // Act
    final result = productDto.toEntity();

    // Assert
    expect(result.id, equals(productDto.id));
    expect(result.price, equals(productDto.price));
  });
}

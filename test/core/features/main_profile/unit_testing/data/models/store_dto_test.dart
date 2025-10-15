import 'package:flowery_tracking_app/features/orders_page/data/models/store_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test StoreDto to StoreDtoEntity", () {
    // Arrange
    final storeDto = StoreDto(
      name: "name",
      image: "image",
      address: "address",
      phoneNumber: "phoneNumber",
      latLong: "latLong",
    );

    // Act
    final result = storeDto.toEntity();

    // Assert
    expect(result.name, equals(storeDto.name));
    expect(result.image, equals(storeDto.image));
    expect(result.address, equals(storeDto.address));
    expect(result.phoneNumber, equals(storeDto.phoneNumber));
    expect(result.latLong, equals(storeDto.latLong));
  });
}

import 'package:flowery_tracking_app/features/orders_page/data/models/metadata_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test MetadataDto to MetadataDtoEntity", () {
    // Arrange
    MetadataDto metadataDto = MetadataDto(
      currentPage: 1,
      totalPages: 1,
      totalItems: 1,
      limit: 1,
    );

    // Act
    var result = metadataDto.toEntity();

    // Assert
    expect(result.currentPage, equals(metadataDto.currentPage));
    expect(result.totalPages, equals(metadataDto.totalPages));
    expect(result.totalItems, equals(metadataDto.totalItems));
    expect(result.limit, equals(metadataDto.limit));
  });
}

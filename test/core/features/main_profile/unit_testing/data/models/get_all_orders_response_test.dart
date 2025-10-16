import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
import 'package:test/test.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/metadata_dto.dart';

void main() {
  late String message;
  late MetadataDto metadataDto;

  setUp(() {
    message = "message";
    metadataDto = MetadataDto(
      currentPage: 1,
      totalPages: 1,
      totalItems: 1,
      limit: 1,
    );
  });
  test('test GetAllOrdersResponse to GetAllOrdersEntity', () {
    // Arrange
    final getAllOrdersResponse = GetAllOrdersResponse(
      message: message,
      metadata: metadataDto,
    );

    // Act
    final getAllOrdersEntity = getAllOrdersResponse.toEntity();

    // Assert
    expect(getAllOrdersEntity.message, equals(getAllOrdersResponse.message));
    expect(
      getAllOrdersEntity.metadataDtoEntity?.currentPage,
      equals(metadataDto.currentPage),
    );
    expect(
      getAllOrdersEntity.metadataDtoEntity?.totalPages,
      equals(metadataDto.totalPages),
    );
    expect(
      getAllOrdersEntity.metadataDtoEntity?.totalItems,
      equals(metadataDto.totalItems),
    );
    expect(
      getAllOrdersEntity.metadataDtoEntity?.limit,
      equals(metadataDto.limit),
    );
  });
}

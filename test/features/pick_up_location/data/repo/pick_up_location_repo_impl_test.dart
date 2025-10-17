import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/pick_up_location/data/source/pick_up_loction_ds.dart';
import 'package:flowery_tracking_app/features/pick_up_location/data/repo/pick_up_location_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pick_up_location_repo_impl_test.mocks.dart';

@GenerateMocks([PickUpLoctionDs])
void main() {
  late PickUpLocationRepoImpl repo;
  late MockPickUpLoctionDs mockDataSource;

  setUp(() {
    mockDataSource = MockPickUpLoctionDs();
    repo = PickUpLocationRepoImpl(mockDataSource);
  });

  group('getRoute', () {
    const start = LatLng(31.0, 30.0);
    const dest = LatLng(31.1, 30.1);
    final mockPoints = [const LatLng(31.0, 30.0), const LatLng(31.05, 30.05)];

    test('should return ApiSuccessResult when data source succeeds', () async {
      // Arrange
      when(
        mockDataSource.getRoute(start, dest),
      ).thenAnswer((_) async => mockPoints);

      // Act
      final result = await repo.getRoute(start, dest);

      // Assert
      expect(result, isA<ApiSuccessResult<List<LatLng>>>());
      final success = result as ApiSuccessResult<List<LatLng>>;
      expect(success.data, equals(mockPoints));
    });

    test(
      'should return ApiErrorResult when data source throws exception',
      () async {
        // Arrange
        when(
          mockDataSource.getRoute(start, dest),
        ).thenThrow(Exception('Failed to fetch route'));

        // Act
        final result = await repo.getRoute(start, dest);

        // Assert
        expect(result, isA<ApiErrorResult<List<LatLng>>>());
        final error = result as ApiErrorResult<List<LatLng>>;
        expect(error.failure.errorMessage, contains('Failed to fetch'));
      },
    );
  });
}

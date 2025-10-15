import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:latlong2/latlong.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/pick_up_location/domin/repo/pick_up_location_repo.dart';
import 'package:flowery_tracking_app/features/pick_up_location/domin/usecase/get_routes_usecase.dart';

@GenerateMocks([PickUpLocationRepo])
import 'get_routes_usecase_test.mocks.dart';

void main() {
  provideDummy<ApiResult<List<LatLng>>>(ApiSuccessResult(data: []));

  late GetRoutesUsecase getRoutesUsecase;
  late MockPickUpLocationRepo mockPickUpLocationRepo;

  setUp(() {
    mockPickUpLocationRepo = MockPickUpLocationRepo();
    getRoutesUsecase = GetRoutesUsecase(mockPickUpLocationRepo);
  });

  const start = LatLng(30.0444, 31.2357);
  const dest = LatLng(29.9792, 31.1342);
  final route = [start, dest];

  test(
    'should return ApiResult.success with route list when repo returns success',
    () async {
      // Arrange
      when(
        mockPickUpLocationRepo.getRoute(start, dest),
      ).thenAnswer((_) async => ApiSuccessResult(data: route));

      // Act
      final result = await getRoutesUsecase(start, dest);

      result as ApiSuccessResult<List<LatLng>>;
      // Assert
      expect(result, isA<ApiResult<List<LatLng>>>());
      expect(result.data, equals(route));
      verify(mockPickUpLocationRepo.getRoute(start, dest)).called(1);
      verifyNoMoreInteractions(mockPickUpLocationRepo);
    },
  );

  test('should return ApiResult.failure when repo returns failure', () async {
    // Arrange
    Exception exception = Exception("Network Error");
    when(mockPickUpLocationRepo.getRoute(start, dest)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: exception.toString())),
    );

    // Act
    final result = await getRoutesUsecase(start, dest);
    // Assert
    expect(result, isA<ApiResult<List<LatLng>>>());
    expect(
      (result as ApiErrorResult).failure.errorMessage,
      equals(exception.toString()),
    );
  });
}

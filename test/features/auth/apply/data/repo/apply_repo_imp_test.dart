import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_model_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/remot_data_source/apply_remot_ds.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/repo/apply_repo_imp.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'apply_repo_imp_test.mocks.dart';

@GenerateMocks([ApplyRemotDataSource])
void main() {
  late MockApplyRemotDataSource mockRemoteDS;
  late ApplyRepoImp repo;

  setUp(() {
    mockRemoteDS = MockApplyRemotDataSource();
    repo = ApplyRepoImp(mockRemoteDS);
  });

  group('vehicles()', () {
    test('should return list of VehicelEntity when success', () async {
      // arrange
      final fakeDto = VehiclesResponseDto(
        message: '',
        vehicles: [
          VehicleModelDto(
            id: 'id',
            type: 'type',
            image: 'image',
            createdAt: 'createdAt',
            updatedAt: 'updatedAt',
            v: 1,
          ),
        ],
      );

      when(mockRemoteDS.getvehicles()).thenAnswer((_) async => fakeDto);

      // act
      final result = await repo.vehicles();

      // assert
      expect(result, isA<ApiSuccessResult<List<VehicelEntity>>>());
      final data = (result as ApiSuccessResult).data;
      expect(data, isNotEmpty);
    });

    test('should return ApiErrorResult when exception thrown', () async {
      // arrange
      when(mockRemoteDS.getvehicles()).thenThrow(Exception('server error'));

      // act
      final result = await repo.vehicles();

      // assert
      expect(result, isA<ApiErrorResult>());
    });
  });
}

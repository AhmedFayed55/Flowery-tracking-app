import 'dart:io';

import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/mapper/mapper_request_to_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/remot_data_source/apply_remot_ds.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/repo/apply_repo.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

@Injectable(as: ApplyRepo)
class ApplyRepoImp implements ApplyRepo {
  final ApplyRemotDataSource _applyRemotDataSource;
  ApplyRepoImp(this._applyRemotDataSource);
  // Future<File> _resizeImage(File file, {int maxWidth = 800, int maxHeight = 800}) async {
  //   final bytes = await file.readAsBytes();
  //   final image = img.decodeImage(bytes);
  //   if (image == null) return file;
  //   final resized = img.copyResize(image, width: maxWidth, height: maxHeight);
  //   final tempFile = File('${file.parent.path}/resized_${file.uri.pathSegments.last}');
  //   await tempFile.writeAsBytes(img.encodeJpg(resized, quality: 85));
  //   return tempFile;
  // }
  // Future<ApiResult<void>> _validateImages(
  //   File license,
  //   File id, {
  //   double threshold = 0.8,
  // }) async {
  //    final resizedLicense = await _resizeImage(license);
  // final resizedId = await _resizeImage(id);
  //   final licenseResult = await _applyRemotDataSource.verifyLicense(resizedLicense);
  //   final licenseLabel = licenseResult['output'][0]['label'];
  //   final licenseConfidence = licenseResult['output'][0]['confidence'];
  //   if (licenseLabel != 'Driver License' || licenseConfidence < threshold) {
  //     return ApiErrorResult(
  //       failure: Failure(errorMessage: 'Invalid license image'),
  //     );
  //   }
  //   final idResult = await _applyRemotDataSource.verifyID(resizedId);
  //   final idLabel = idResult['output'][0]['label'];
  //   final idConfidence = idResult['output'][0]['confidence'];
  //   if (idLabel != 'ID Card' || idConfidence < threshold) {
  //     return ApiErrorResult(failure: Failure(errorMessage: 'Invalid ID image'));
  //   }
  //   return ApiSuccessResult(data: null);
  // }

  @override
  Future<ApiResult<DriverEntity>> apply(
    RequestApplyEntity requestEntity,
  ) async {
    // final validation = await _validateImages(
    //   requestEntity.vehicleLicense,
    //   requestEntity.nIDImg,
    // );
    // if (validation is ApiErrorResult) {
    //   return ApiErrorResult(failure: validation.failure);
    // }

    return safeApiCall(() async {
      final response = await _applyRemotDataSource.applyDriver(
        toModelDto(requestEntity),
      );
      return response.driver.toDomain();
    });
  }

  @override
  Future<ApiResult<List<VehicelEntity>>> vehicles() async {
    return safeApiCall(() async {
      final response = await _applyRemotDataSource.getvehicles();
      return response.vehicles.map((e) => e.toDomain()).toList();
    });
  }
}

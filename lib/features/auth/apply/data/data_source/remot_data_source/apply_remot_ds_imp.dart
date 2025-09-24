import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/gemeni_api_service.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/request/apply_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/remot_data_source/apply_remot_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApplyRemotDataSource)
class ApplyRemotDataSourceImp implements ApplyRemotDataSource {
  final ApiServices _apiServices;
  final GeminiApiService _geminiApiService;
  ApplyRemotDataSourceImp(this._apiServices, this._geminiApiService);
  @override
  Future<ApplyResponceDto> applyDriver(ApplyRequestDto applyRequestDto) async {
    final formData = FormData.fromMap({
      ...applyRequestDto.toPartMap(),
      AppConstants.vehicleLicenseKey: await applyRequestDto.vehicleLicensePart,
      AppConstants.nIDImgKey: await applyRequestDto.nIDImgPart,
    });
    return _apiServices.apply(formData);
  }

  @override
  Future<VehiclesResponseDto> getvehicles() {
    return _apiServices.getAllVehicles();
  }

  @override
  Future<Map<String, dynamic>> verifyID(File imageId) {
    return _geminiApiService.sendImage(
      image: imageId,
      instructions: "Check if this is a valid ID Card",
    );
  }

  @override
  Future<Map<String, dynamic>> verifyLicense(File license) {
    return _geminiApiService.sendImage(
      image: license,
      instructions: "Check if this is a valid Driver License",
    );
  }
}

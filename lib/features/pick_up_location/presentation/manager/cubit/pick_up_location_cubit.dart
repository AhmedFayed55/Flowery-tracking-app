import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/pick_up_location/domin/usecase/get_routes_usecase.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_event.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_state.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/widgets/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'dart:async';

@injectable
class PickUpCubit extends Cubit<PickUpState> {
  final GetRoutesUsecase pickUpLocationRepo;
  final Location location;
  StreamSubscription<LocationData>? locationSubscription;
  final MapController mapController = MapController();
  PickUpCubit(this.pickUpLocationRepo, this.location)
    : super(const PickUpState());

  Future<void> doIntent(PickUpEvent event) async {
    switch (event) {
      case InitializeMapEvent():
        await _handleInitializeMap(event.destination);
        break;

      case GetRouteEvent():
        await _handleGetRoute(event.destination);
        break;

      case ResetEvent():
        emit(const PickUpState());
        break;
    }
  }

  Future<void> _handleInitializeMap(LatLng destination) async {
    emit(state.copyWith(isLoading: true));
    checkLocationPermission();
    try {
      var current = await location.getLocation();

      final userLatLng = LatLng(current.latitude!, current.longitude!);

      final newMarkers = [
        Marker(
          width: 95,
          height: 26,
          point: userLatLng,
          child: customMarker(
            const Icon(Icons.my_location, color: AppColors.white, size: 16),
            'Your Location',
          ),
        ),
        Marker(
          width: 95,
          height: 26,
          point: destination,
          child: customMarker(
            const Icon(Icons.person, color: AppColors.white, size: 16),
            'Destination',
          ),
        ),
      ];

      var newRoute = await _handleGetRoute(destination);

      emit(
        state.copyWith(
          isLoading: false,
          currentLocation: current,
          markers: newMarkers,
          routePoints: newRoute,
        ),
      );

      _startLiveLocationUpdates(destination);
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _startLiveLocationUpdates(LatLng destination) async {
    locationSubscription?.cancel();
    // location.changeSettings(
    //   accuracy: LocationAccuracy.low,
    //   interval: 1000,
    //   distanceFilter: 0,
    // );

    locationSubscription = location.onLocationChanged.listen(
      (event) async {
        final newRoute = await _handleGetRoute(destination);

        final updatedUserMarker = Marker(
          width: 95,
          height: 26,
          point: LatLng(event.latitude!, event.longitude!),
          child: customMarker(
            const Icon(Icons.my_location, color: AppColors.white, size: 16),
            'Your Location',
          ),
        );

        final destinationMarker = state.markers.firstWhere(
          (m) => m.point == destination,
          orElse: () => Marker(
            width: 95,
            height: 26,
            point: destination,
            child: customMarker(
              const Icon(Icons.person, color: AppColors.white, size: 16),
              'Destination',
            ),
          ),
        );

        final updatedMarkers = [updatedUserMarker, destinationMarker];

        emit(
          state.copyWith(
            currentLocation: event,
            routePoints: newRoute == [] ? state.routePoints : newRoute,
            markers: updatedMarkers,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(errorMessage: error.toString()));
      },
    );
  }

  Future<List<LatLng>> _handleGetRoute(LatLng dest) async {
    if (state.currentLocation == null) return [];

    final start = LatLng(
      state.currentLocation!.latitude!,
      state.currentLocation!.longitude!,
    );

    final result = await pickUpLocationRepo.call(start, dest);

    switch (result) {
      case ApiSuccessResult():
        return result.data;
      case ApiErrorResult():
        return [];
    }
  }

  @override
  Future<void> close() {
    mapController.dispose();
    locationSubscription?.cancel();
    return super.close();
  }
}

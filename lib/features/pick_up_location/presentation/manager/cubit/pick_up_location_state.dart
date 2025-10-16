import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class PickUpState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final LocationData? currentLocation;
  final List<LatLng> routePoints;
  final List<Marker> markers;

  const PickUpState({
    this.isLoading = false,
    this.errorMessage,
    this.currentLocation,
    this.routePoints = const [],
    this.markers = const [],
  });

  PickUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    LocationData? currentLocation,
    List<LatLng>? routePoints,
    List<Marker>? markers,
  }) {
    return PickUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentLocation: currentLocation ?? this.currentLocation,
      routePoints: routePoints ?? this.routePoints,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    currentLocation,
    routePoints,
    markers,
  ];
}

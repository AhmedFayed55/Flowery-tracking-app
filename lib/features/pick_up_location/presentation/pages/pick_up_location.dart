import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/widgets/map_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_cubit.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_event.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_state.dart';

class PickUpLocationPage extends StatefulWidget {
  const PickUpLocationPage({
    super.key,
    required this.user,
    required this.store,
  });
  final UserEntity user;
  final StoreEntity store;

  @override
  State<PickUpLocationPage> createState() => _PickUpLocationPageState();
}

class _PickUpLocationPageState extends State<PickUpLocationPage> {
  LatLng toLatLng(String address) {
    final parts = address.split(',');

    final latitude = double.parse(parts[0]);
    final longitude = double.parse(parts[1]);

    return LatLng(latitude, longitude);
  }

  @override
  void initState() {
    var dest = toLatLng(widget.store.latLong!);

    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<PickUpCubit>().doIntent(InitializeMapEvent(dest));
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding16width = context.width * 0.043;
    final size24height = context.height * 0.03;
    final size16height = context.height * 0.016;
    final size36height = context.height * 0.036;
    final size8height = context.height * 0.008;
    final mapHeight = context.height * 0.66;
    var mapController = context.read<PickUpCubit>().mapController;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Row(
          children: [
            horizontalSpace(16),
            SizedBox(
              height: size36height,
              width: size36height,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  radius: 21,
                  backgroundColor: AppColors.pink,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<PickUpCubit, PickUpState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.pink),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.currentLocation == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.pink),
            );
          }

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      height: mapHeight,
                      width: double.infinity,
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(
                            state.currentLocation!.latitude!,
                            state.currentLocation!.longitude!,
                          ),
                          initialZoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: AppConstants.mapUrlTemplate,
                            userAgentPackageName:
                                'com.example.flowery_tracking_app',
                          ),
                          if (state.routePoints.isNotEmpty)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: state.routePoints,
                                  strokeWidth: 5,
                                  color: AppColors.pink,
                                ),
                              ],
                            ),
                          MarkerLayer(markers: state.markers),
                        ],
                      ),
                    ),

                    Positioned(
                      right: padding16width,
                      bottom: size24height,
                      child: FloatingActionButton(
                        backgroundColor: AppColors.pink,
                        onPressed: () {
                          if (state.currentLocation != null) {
                            mapController.move(
                              LatLng(
                                state.currentLocation!.latitude!,
                                state.currentLocation!.longitude!,
                              ),
                              15,
                            );
                          }
                        },
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(size16height),
              MapData(user: widget.user, store: widget.store),
              verticalSpace(size8height),
            ],
          );
        },
      ),
    );
  }
}

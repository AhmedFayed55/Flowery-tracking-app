import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_cubit.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/manager/cubit/pick_up_location_state.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/pick_up_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pick_up_location_test.mocks.dart';

@GenerateMocks([PickUpCubit, MapController])
void main() {
  late MockPickUpCubit mockCubit;
  late UserEntity user;
  late StoreEntity store;
  late MapController realMapController;

  setUpAll(() {
    realMapController = MapController();
  });

  setUp(() {
    mockCubit = MockPickUpCubit();

    user = UserEntity(
      firstName: 'Ahmed',
      lastName: 'Yehia',
      phone: '01000000000',
      photo: 'https://example.com/user.jpg',
    );

    store = StoreEntity(
      name: 'Flowery Store',
      address: 'Zayed City, Giza',
      phoneNumber: '0200000000',
      image: 'https://example.com/store.jpg',
      latLong: '30.0,31.0',
    );

    when(mockCubit.mapController).thenReturn(realMapController);
  });

  Widget buildTestable(Widget widget) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<PickUpCubit>.value(value: mockCubit, child: widget),
    );
  }

  testWidgets('shows loading indicator when isLoading = true', (tester) async {
    // Arrange
    when(mockCubit.state).thenReturn(const PickUpState(isLoading: true));

    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.value(const PickUpState(isLoading: true)));

    // Act
    await tester.pumpWidget(
      buildTestable(PickUpLocationPage(user: user, store: store)),
    );
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when errorMessage is set', (tester) async {
    // Arrange
    const errorMessage = 'Something went wrong';
    when(mockCubit.state).thenReturn(
      const PickUpState(isLoading: false, errorMessage: errorMessage),
    );

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(
        const PickUpState(isLoading: false, errorMessage: errorMessage),
      ),
    );

    // Act
    await tester.pumpWidget(
      buildTestable(PickUpLocationPage(user: user, store: store)),
    );
    await tester.pump();

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('shows map and map data when state is ready', (tester) async {
    // Arrange
    final location = LocationData.fromMap({
      'latitude': 29.99,
      'longitude': 30.99,
    });
    final routePoints = [const LatLng(29.99, 30.99), const LatLng(30.0, 31.0)];

    final readyState = PickUpState(
      isLoading: false,
      currentLocation: location,
      routePoints: routePoints,
    );

    when(mockCubit.state).thenReturn(readyState);

    when(mockCubit.stream).thenAnswer((_) => Stream.value(readyState));

    // Act
    await tester.pumpWidget(
      buildTestable(PickUpLocationPage(user: user, store: store)),
    );
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.text('Flowery Store'), findsOneWidget);
    expect(find.text('Ahmed Yehia'), findsOneWidget);
  });
}

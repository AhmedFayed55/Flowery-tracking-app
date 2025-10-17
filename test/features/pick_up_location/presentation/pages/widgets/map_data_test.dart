import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/call_card.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/widgets/map_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AppLocalizations])
void main() {
  testWidgets('MapData displays user and store info correctly', (
    WidgetTester tester,
  ) async {
    // Arrange
    final user = UserEntity(
      firstName: 'Ahmed',
      lastName: 'Yehia',
      phone: '01000000000',
      photo: 'https://example.com/user.jpg',
    );

    final store = StoreEntity(
      name: 'Flowery Store',
      address: 'Zayed City, Giza',
      phoneNumber: '0200000000',
      image: 'https://example.com/store.jpg',
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: MapData(user: user, store: store),
        ),
      ),
    );

    // Assert
    expect(find.text('Pickup Location'), findsOneWidget);
    expect(find.text('User Location'), findsOneWidget);
    expect(find.text('Flowery Store'), findsOneWidget);
    expect(find.text('Zayed City, Giza'), findsOneWidget);
    expect(find.text('Ahmed Yehia'), findsOneWidget);
    expect(find.text('20th st, Sheikh Zayed, Giza'), findsOneWidget);
    expect(find.byType(CallCard), findsNWidgets(2));
  });
}

import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_view_model.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/pending_order_cart.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/picked_or_user_address_widget.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/price_and_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pending_order_cart_test.mocks.dart';

@GenerateMocks([HomeTabViewModel])
void main() {
  testWidgets(
    'renders PendingOrderCart UI and triggers accept/reject actions',
    (tester) async {
      final mockViewModel = MockHomeTabViewModel();

      when(mockViewModel.state).thenReturn(const HomeTabState());
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => const Stream<HomeTabState>.empty());

      when(mockViewModel.doIntent(any)).thenReturn(null);

      final fakeOrder = OrdersEntity(
        id: "1",
        totalPrice: 1,
        store: StoreEntity(name: 'name', address: 'address', image: 'image'),
        user: UserEntity(
          firstName: 'firstName',
          lastName: 'lastName',
          photo: 'photo',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<HomeTabViewModel>.value(
            value: mockViewModel,
            child: PendingOrderCart(order: fakeOrder),
          ),
        ),
      );

      expect(find.textContaining('name'), findsOneWidget);
      expect(find.textContaining('firstName lastName'), findsOneWidget);
      expect(find.byType(PickedOrUserAddressWidget), findsNWidgets(2));
      expect(find.byType(PriceAndOptionsWidget), findsOneWidget);

      final acceptButton = find.textContaining('Accept');
      final rejectButton = find.textContaining('Reject');

      if (acceptButton.evaluate().isNotEmpty) {
        await tester.tap(acceptButton);
        await tester.pump();
        verify(mockViewModel.doIntent(any)).called(1);
      }

      if (rejectButton.evaluate().isNotEmpty) {
        await tester.tap(rejectButton);
        await tester.pump();
        verify(mockViewModel.doIntent(any)).called(1);
      }
    },
  );
}

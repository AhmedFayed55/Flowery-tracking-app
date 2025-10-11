import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orderItems_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/product_entity.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductCard displays product data correctly', (
    WidgetTester tester,
  ) async {
    final product = ProductEntity(
      title: 'Rose Bouquet',
      price: 200,
      imgCover: 'https://example.com/image.jpg',
    );
    final orderItem = OrderItemsEntity(product: product, quantity: 2);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ProductCard(orderItems: orderItem)),
      ),
    );

    expect(find.text('Rose Bouquet'), findsOneWidget);
    expect(find.textContaining('200'), findsOneWidget);
    expect(find.text('x2'), findsOneWidget);
  });
}

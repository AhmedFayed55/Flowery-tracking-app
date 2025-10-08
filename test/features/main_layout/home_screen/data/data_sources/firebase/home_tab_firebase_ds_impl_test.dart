// import 'package:flowery_tracking_app/core/services/firebase_services.dart';
// import 'package:flowery_tracking_app/core/utils/constants.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds_impl.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'home_tab_firebase_ds_impl_test.mocks.dart';
//
// @GenerateMocks([FirebaseService])
// void main() {
//   late MockFirebaseService mockFirebaseService;
//   late HomeTabFirebaseDataSourceImpl dataSource;
//
//   setUp(() {
//     mockFirebaseService = MockFirebaseService();
//     dataSource = HomeTabFirebaseDataSourceImpl(mockFirebaseService);
//   });
//
//   test(
//     'verify when call saveOrder it should call addData from FirebaseService with correct parameters',
//         () async {
//       const String orderId = '123';
//       final order = OrdersDto(id: orderId);
//
//       when(
//         mockFirebaseService.addData(
//           any,
//           any,
//           any,
//         ),
//       ).thenAnswer((_) async => Future.value());
//
//       await dataSource.saveOrder(order);
//
//       verify(
//         mockFirebaseService.addData(
//           AppConstants.ordersCollection,
//           orderId,
//           order.toJson(),
//         ),
//       ).called(1);
//     },
//   );
// }
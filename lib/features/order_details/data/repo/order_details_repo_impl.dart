import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/maper/to_entity_maper.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/data/sources/order_details_ds.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: OrderDetailsRepo)
class OrderDetailsRepoImpl implements OrderDetailsRepo {
  final OrderDetailsDs _orderDetailsDs;
  final InternetConnectionChecker _internetConnectionChecker;
  OrderDetailsRepoImpl(this._orderDetailsDs, this._internetConnectionChecker);
  @override
  Future<FirebaseResult<OrdersEntity>> getOrderDetails(String orderId) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return FirebaseErrorResult<OrdersEntity>(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }

    try {
      final result = await _orderDetailsDs.getOrderDetails(orderId);

      if (result == null) {
        return FirebaseErrorResult<OrdersEntity>(
          failure: Failure(errorMessage: "Order with ID $orderId not found."),
        );
      }

      return FirebaseSuccessResult<OrdersEntity>(data: toOrdersEntity(result));
    } on FirebaseException catch (firebaseError) {
      return FirebaseErrorResult<OrdersEntity>(
        failure: Failure(
          errorMessage: firebaseError.message ?? "Unknown Firebase error",
        ),
      );
    } catch (e) {
      return FirebaseErrorResult<OrdersEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }

  @override
  Future<FirebaseResult> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return FirebaseErrorResult<OrdersEntity>(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }

    // try {
    //   await _orderDetailsDs.updateOrderStatusFirebase(orderId, status);
    //   return FirebaseSuccessResult(data: null);
    // } on FirebaseException catch (firebaseError) {
    //   return FirebaseErrorResult(
    //     failure: Failure(
    //       errorMessage: firebaseError.message ?? "Unknown Firebase error",
    //     ),
    //   );
    // } catch (e) {
    //   return FirebaseErrorResult(failure: Failure(errorMessage: e.toString()));
    // }
  
    return safeFirebaseCall(() => _orderDetailsDs.updateOrderStatusFirebase(orderId, status));
  }

  @override
  Future<FirebaseResult> updateDriverLocation(
    String orderId,
    String location,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return FirebaseErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }
    // try {
    //   await _orderDetailsDs.updateDriverLocation(orderId, location);
    //   return FirebaseSuccessResult(data: null);
    // } on FirebaseException catch (firebaseError) {
    //   return FirebaseErrorResult(
    //     failure: Failure(
    //       errorMessage: firebaseError.message ?? "Unknown Firebase error",
    //     ),
    //   );
    // } catch (e) {
    //   return FirebaseErrorResult(failure: Failure(errorMessage: e.toString()));
    // }

    return safeFirebaseCall(() => _orderDetailsDs.updateDriverLocation(orderId, location));
  }

  @override
  Stream<Map<String, dynamic>?> streamOrder(String orderId) {
    return _orderDetailsDs.streamOrder(orderId).map((snapshot) {
      return snapshot.data();
    });
  }
}

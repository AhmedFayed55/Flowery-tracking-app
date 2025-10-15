import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';

class GetAllOrdersState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final GetAllOrdersEntity? getAllOrdersEntity;

  GetAllOrdersState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.getAllOrdersEntity,
  });

  GetAllOrdersState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    GetAllOrdersEntity? getAllOrdersEntity,
  }) {
    return GetAllOrdersState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      getAllOrdersEntity: getAllOrdersEntity ?? this.getAllOrdersEntity,
    );
  }
}

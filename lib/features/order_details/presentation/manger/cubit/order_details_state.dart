part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  final bool isSceenLoading;
  final bool isLoading;
  final bool isUpdating;
  final OrdersEntity? orderDetails;
  final RiderOrderStatus? riderOrderStatus;
  final String? errorMessage;
  final bool isOrderCompleted;

  const OrderDetailsState({
    required this.isSceenLoading,
    required this.isLoading,
    required this.isUpdating,
    this.orderDetails,
    this.riderOrderStatus,
    required this.isOrderCompleted,
    this.errorMessage,
  });

  factory OrderDetailsState.initial() {
    return const OrderDetailsState(
      isOrderCompleted: false,
      isSceenLoading: true,
      isLoading: false,
      isUpdating: false,
      orderDetails: null,
      riderOrderStatus: null,
      errorMessage: null,
    );
  }

  OrderDetailsState copyWith({
    bool? isOrderCompleted,
    bool? isLoading,
    bool? isUpdating,
    bool? isSceenLoading,
    OrdersEntity? orderDetails,
    RiderOrderStatus? riderOrderStatus,
    String? errorMessage,
  }) {
    return OrderDetailsState(
      isOrderCompleted:  isOrderCompleted ?? this.isOrderCompleted,
      isSceenLoading: isSceenLoading ?? this.isSceenLoading,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      orderDetails: orderDetails ?? this.orderDetails,
      riderOrderStatus: riderOrderStatus ?? this.riderOrderStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isOrderCompleted,
    isLoading,
    isUpdating,
    orderDetails,
    riderOrderStatus,
    isSceenLoading,
    errorMessage,
  ];
}

part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  final bool isSceenLoading;
  final bool isLoading;
  final bool isUpdating;
  final OrdersEntity? orderDetails;
  final RiderOrderStatus? riderOrderStatus;
  final String? errorMessage;

  const OrderDetailsState({
    required this.isSceenLoading,
    required this.isLoading,
    required this.isUpdating,
    this.orderDetails,
    this.riderOrderStatus,
    this.errorMessage,
  });

  factory OrderDetailsState.initial() {
    return const OrderDetailsState(
      isSceenLoading: true,
      isLoading: false,
      isUpdating: false,
      orderDetails: null,
      riderOrderStatus: null,
      errorMessage: null,
    );
  }

  OrderDetailsState copyWith({
    bool? isLoading,
    bool? isUpdating,
    bool? isSceenLoading,
    OrdersEntity? orderDetails,
    RiderOrderStatus? riderOrderStatus,
    String? errorMessage,
  }) {
    return OrderDetailsState(
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
    isLoading,
    isUpdating,
    orderDetails,
    riderOrderStatus,
    isSceenLoading,
    errorMessage,
  ];
}

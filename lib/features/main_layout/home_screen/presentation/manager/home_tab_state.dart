import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';

class HomeTabState extends Equatable {
  final bool isLoadingGetOrders;
  final bool isLoadingMore;
  final String? errorGetOrders;
  final List<OrdersEntity> orders;
  final bool isLoadingSaveOrder;
  final String? errorSaveOrder;
  final bool isOrderSaved;
  final DriverDataEntity? driverData;
  final bool isOrderStateUpdated;
  final int currentPage;
  final int? totalPages;
  final bool hasMoreData;

  const HomeTabState({
    this.isOrderStateUpdated = false,
    this.driverData,
    this.isLoadingSaveOrder = false,
    this.errorSaveOrder,
    this.isOrderSaved = false,
    this.isLoadingGetOrders = false,
    this.isLoadingMore = false,
    this.errorGetOrders,
    this.orders = const [],
    this.currentPage = 1,
    this.totalPages,
    this.hasMoreData = true,
  });

  HomeTabState copyWith({
    bool? isLoadingGetOrders,
    bool? isLoadingMore,
    String? errorGetOrders,
    List<OrdersEntity>? orders,
    bool? isLoadingSaveOrder,
    String? errorSaveOrder,
    bool? isOrderSaved,
    DriverDataEntity? driverData,
    bool? isOrderStateUpdated,
    int? currentPage,
    int? totalPages,
    bool? hasMoreData,
  }) {
    return HomeTabState(
      isLoadingGetOrders: isLoadingGetOrders ?? this.isLoadingGetOrders,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorGetOrders: errorGetOrders,
      orders: orders ?? this.orders,
      isLoadingSaveOrder: isLoadingSaveOrder ?? this.isLoadingSaveOrder,
      errorSaveOrder: errorSaveOrder,
      isOrderSaved: isOrderSaved ?? this.isOrderSaved,
      driverData: driverData ?? this.driverData,
      isOrderStateUpdated: isOrderStateUpdated ?? this.isOrderStateUpdated,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingGetOrders,
    isLoadingMore,
    errorGetOrders,
    orders,
    isLoadingSaveOrder,
    errorSaveOrder,
    isOrderSaved,
    driverData,
    isOrderStateUpdated,
    currentPage,
    totalPages,
    hasMoreData,
  ];
}

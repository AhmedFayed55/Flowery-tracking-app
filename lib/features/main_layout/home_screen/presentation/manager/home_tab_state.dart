import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';

class HomeTabState extends Equatable{
  final bool isLoadingGetOrders;
  final String? errorGetOrders;
  final List<OrdersEntity> orders;
  final bool isLoadingSaveOrder;
  final String? errorSaveOrder;
  final bool isOrderSaved;
  final DriverDataEntity? driverData;
  final bool isOrderStateUpdated;

  const HomeTabState({
    this.isOrderStateUpdated = false,
    this.driverData,
    this.isLoadingSaveOrder = false,
    this.errorSaveOrder,
    this.isOrderSaved = false,
    this.isLoadingGetOrders = false,
    this.errorGetOrders,
    this.orders = const [],
  });

  HomeTabState copyWith({
    bool? isLoadingGetOrders,
    String? errorGetOrders,
    List<OrdersEntity>? orders,
    bool? isLoadingSaveOrder,
    String? errorSaveOrder,
    bool? isOrderSaved,
    DriverDataEntity? driverData,
    bool? isOrderStateUpdated,
  }){
    return HomeTabState(
      isLoadingGetOrders: isLoadingGetOrders ?? this.isLoadingGetOrders,
      errorGetOrders: errorGetOrders ?? this.errorGetOrders,
      orders: orders ?? this.orders,
      isLoadingSaveOrder: isLoadingSaveOrder ?? this.isLoadingSaveOrder,
      errorSaveOrder: errorSaveOrder ?? this.errorSaveOrder,
      isOrderSaved: isOrderSaved ?? this.isOrderSaved,
      driverData: driverData ?? this.driverData,
      isOrderStateUpdated: isOrderStateUpdated ?? this.isOrderStateUpdated,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingGetOrders,
    errorGetOrders,
    orders,
    isLoadingSaveOrder,
    errorSaveOrder,
    isOrderSaved,
    driverData,
    isOrderStateUpdated,
  ];

}
import 'package:equatable/equatable.dart';
import '../../domain/entities/orders_entity.dart';

class HomeTabState extends Equatable{
  final bool isLoadingGetOrders;
  final String? errorGetOrders;
  final List<OrdersEntity> orders;
  final bool isLoadingSaveOrder;
  final String? errorSaveOrder;
  final bool isOrderSaved;

  const HomeTabState({
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
  }){
    return HomeTabState(
      isLoadingGetOrders: isLoadingGetOrders ?? this.isLoadingGetOrders,
      errorGetOrders: errorGetOrders ?? this.errorGetOrders,
      orders: orders ?? this.orders,
      isLoadingSaveOrder: isLoadingSaveOrder ?? this.isLoadingSaveOrder,
      errorSaveOrder: errorSaveOrder ?? this.errorSaveOrder,
      isOrderSaved: isOrderSaved ?? this.isOrderSaved,
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
  ];

}
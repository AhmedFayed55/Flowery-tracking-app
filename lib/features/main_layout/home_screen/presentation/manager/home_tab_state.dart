import 'package:equatable/equatable.dart';
import '../../domain/entities/orders_entity.dart';

class HomeTabState extends Equatable{
  final bool isLoadingGetOrders;
  final String? errorGetOrders;
  final List<OrdersEntity> orders;

  const HomeTabState({
    this.isLoadingGetOrders = false,
    this.errorGetOrders,
    this.orders = const [],
  });

  HomeTabState copyWith({
    bool? isLoadingGetOrders,
    String? errorGetOrders,
    List<OrdersEntity>? orders,
  }){
    return HomeTabState(
      isLoadingGetOrders: isLoadingGetOrders ?? this.isLoadingGetOrders,
      errorGetOrders: errorGetOrders ?? this.errorGetOrders,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingGetOrders,
    errorGetOrders,
    orders,
  ];

}
import 'package:equatable/equatable.dart';
import '../../domain/entities/get_pending_orders_entity.dart';

class HomeTabState extends Equatable{
  final bool isLoadingGetOrders;
  final String? errorGetOrders;
  final GetPendingOrdersEntity? getPendingOrdersEntity;

  const HomeTabState({
    this.isLoadingGetOrders = false,
    this.errorGetOrders,
    this.getPendingOrdersEntity,
  });

  HomeTabState copyWith({
    bool? isLoadingGetOrders,
    String? errorGetOrders,
    GetPendingOrdersEntity? getPendingOrdersEntity,
  }){
    return HomeTabState(
      isLoadingGetOrders: isLoadingGetOrders ?? this.isLoadingGetOrders,
      errorGetOrders: errorGetOrders ?? this.errorGetOrders,
      getPendingOrdersEntity: getPendingOrdersEntity ?? this.getPendingOrdersEntity,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingGetOrders,
    errorGetOrders,
    getPendingOrdersEntity,
  ];

}
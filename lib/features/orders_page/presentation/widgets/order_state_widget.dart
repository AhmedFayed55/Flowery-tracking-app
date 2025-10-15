import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_state_model.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStateWidget extends StatelessWidget {
  final OrderStateModel orderState;
  final int index;

  const OrderStateWidget({
    super.key,
    required this.index,
    required this.orderState,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var cubit = context.read<GetAllOrdersCubit>().state.getAllOrdersEntity;
    var orderStateApi = cubit?.ordersDtoEntity?[index].orderDtoEntity?.state;
    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth * 0.41,
      decoration: BoxDecoration(
        color: AppColors.pink[30],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderState.state == orderStateApi
                ? "${cubit?.metadataDtoEntity?.totalItems}"
                : "0",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            children: [
              orderState.icon,
              horizontalSpace(5),
              Text(
                orderState.state,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}

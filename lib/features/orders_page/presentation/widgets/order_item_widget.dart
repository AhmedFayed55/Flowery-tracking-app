import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_cubit.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  const OrderItemWidget({super.key,required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .35,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3)],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localization.flower_order,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
              ),
              verticalSpace(16),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.green,
                    size: 24,
                  ),
                  horizontalSpace(5),
                  Text(
                    "${state.getAllOrdersEntity?.ordersDtoEntity?[index].orderDtoEntity?.state}",
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(color: AppColors.green),
                  ),
                  const Spacer(),
                  Text(
                    "${state.getAllOrdersEntity?.ordersDtoEntity?[index].orderDtoEntity?.orderNumber}",
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(color: AppColors.black),
                  ),
                ],
              ),
              verticalSpace(16),
              Text(
                context.localization.pickup_address,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(8),
              Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * .073,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 3),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: 25,
                      backgroundImage: NetworkImage("${state.getAllOrdersEntity?.ordersDtoEntity?[index].storeDtoEntity?.image}"),
                    ),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${state.getAllOrdersEntity?.ordersDtoEntity?[index].storeDtoEntity?.name}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 13),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            horizontalSpace(4),
                            Text(
                              "${state.getAllOrdersEntity?.ordersDtoEntity?[index].storeDtoEntity?.address}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              Text(
                context.localization.user_address,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(8),
              Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * .073,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 3),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 25, backgroundColor: AppColors.pink),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${state.getAllOrdersEntity?.ordersDtoEntity?[index].
                          orderDtoEntity?.userDtoEntity?.firstName}" " ${state.
                          getAllOrdersEntity?.ordersDtoEntity?[index].
                          orderDtoEntity?.userDtoEntity?.lastName}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 13),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            horizontalSpace(4),
                            Text(
                              "20th st, Sheikh Zayed, Giza",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

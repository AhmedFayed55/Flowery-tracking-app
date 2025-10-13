import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_cubit.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_event.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final getAllOrdersCubit = getIt.get<GetAllOrdersCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getAllOrdersCubit..doIntent(GetAllOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(context.localization.my_orders),
          leading: const Icon(Icons.arrow_back_ios),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9ECF0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "4",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.cancel_outlined,
                                color: AppColors.red,
                                size: 24,
                              ),
                              horizontalSpace(5),
                              Text(
                                context.localization.cancelled,
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium?.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(33),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.pink[30],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.green,
                                size: 24,
                              ),
                              horizontalSpace(5),
                              Text(
                                context.localization.completed,
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium?.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              Text(
                context.localization.recent_orders,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              verticalSpace(10),
              BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
                builder: (context, state) {
                  if (state.getAllOrdersEntity?.ordersDtoEntity! == null ||
                      state.getAllOrdersEntity!.ordersDtoEntity!.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return OrderItemWidget(index: index);
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(16);
                        },
                        itemCount:
                            state.getAllOrdersEntity?.ordersDtoEntity?.length ?? 0,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

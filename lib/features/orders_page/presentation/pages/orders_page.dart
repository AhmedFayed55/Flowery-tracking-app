import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_state_model.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_event.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/widgets/order_item_widget.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/widgets/order_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final getAllOrdersCubit = getIt.get<GetAllOrdersCubit>();

  @override
  Widget build(BuildContext context) {
    var screensHeight = context.height;
    var orderState = OrderStateModel.getOrderStates();
    return BlocProvider(
      create: (context) => getAllOrdersCubit..doIntent(GetAllOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.my_orders),
          leading: const Icon(Icons.arrow_back_ios),
        ),
        body: BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.pink),
              );
            }
            if (state.isError) {
              return Center(
                child: Text(
                  context.localization.no_orders_found,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,
                ),
              );
            }
            if (state.isSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: screensHeight * 0.085,
                          child: ListView.separated(
                            physics: const PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return OrderStateWidget(
                                orderState: orderState[index],
                                index: index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return horizontalSpace(33);
                            },
                            itemCount: orderState.length,
                          ),
                        ),
                        verticalSpace(16),
                        Text(
                          context.localization.recent_orders,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelMedium,
                        ),
                        verticalSpace(10),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return OrderItemWidget(index: index);
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(16);
                        },
                        itemCount:
                        state.getAllOrdersEntity?.ordersDtoEntity?.length ??
                            0,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  context.localization.something_went_wrong,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

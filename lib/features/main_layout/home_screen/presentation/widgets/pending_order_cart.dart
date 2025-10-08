import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_view_model.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/picked_or_user_address_widget.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/price_and_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrderCart extends StatelessWidget {
  const PendingOrderCart({super.key, required this.order});

  final OrdersEntity order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            context.localization.flower_order,
            style: context.textTheme.bodyMedium!.copyWith(
              color: const Color(0xff0C1015),
            ),
          ),
          Text(
            context.localization.picked_address,
            style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
          ),
          PickedOrUserAddressWidget(
            name: order.store?.name ?? '',
            address: order.store?.address ?? '',
            image: order.store?.image ?? '',
          ),
          Text(
            context.localization.picked_address,
            style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
          ),
          PickedOrUserAddressWidget(
            name: "${order.user?.firstName} ${order.user?.lastName}",
            address: '20th st, Sheikh Zayed, Giza ',
            image: order.user?.photo ?? '',
          ),
          PriceAndOptionsWidget(
            price: order.totalPrice!.toInt(),
            rejectOnTap: () => context.read<HomeTabViewModel>().doIntent(
              RejectOrderEvent(order.id!),
            ),
            acceptOnTap: () => context.read<HomeTabViewModel>().doIntent(
              SaveOrderEvent(order),
            ),
          ),
        ],
      ),
    );
  }
}

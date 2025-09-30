import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/picked_or_user_address_widget.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/price_and_options_widget.dart';
import 'package:flutter/material.dart';

class PendingOrderCart extends StatelessWidget {
  const PendingOrderCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const PickedOrUserAddressWidget(
            name: 'Flower Store',
            address: '5845asdasfascaszcasc',
          ),
          Text(
            context.localization.picked_address,
            style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
          ),
          const PickedOrUserAddressWidget(
            name: 'Ahmed Fayed',
            address: 'asfasgasdg45asfas',
          ),
          PriceAndOptionsWidget(price: 3000,
              rejectOnTap:(){}, acceptOnTap: (){},)
        ],
      ),
    );
  }
}

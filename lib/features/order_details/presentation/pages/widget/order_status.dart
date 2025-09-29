import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status : Accepted',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.green),
            ),
            verticalSpace(8),
    
            Text(
              'Order #123456',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(8),
            Text(
              'Wed, 03 Sep 2024, 11:00 AM ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.darkGrey.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


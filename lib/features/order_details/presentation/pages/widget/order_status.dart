import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.orderId, required this.date});
  final String orderId;
  final String date;

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;

    var size8height = context.height * 0.008;

    var trans = context.localization;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding16width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status : Accepted',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.green),
            ),
            verticalSpace(size8height),

            Text(
              '${trans.order} $orderId',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            verticalSpace(size8height),
            Text(
              date,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.darkGrey.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
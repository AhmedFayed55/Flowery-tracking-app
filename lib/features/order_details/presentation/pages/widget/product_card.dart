import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/order_items_entity.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.orderItems});
  final OrderItemsEntity orderItems;

  @override
  Widget build(BuildContext context) {
    var trans = context.localization;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white[10],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.shade100.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,

              backgroundColor: AppColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 44,
                  width: 44,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, color: AppColors.pink, size: 30),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                      ? child
                      : const CircularProgressIndicator(color: AppColors.pink),
                  orderItems.product!.imgCover!.contains('http') ||
                          orderItems.product!.imgCover!.contains('https')
                      ? orderItems.product!.imgCover!
                      : 'https://flower.elevateegy.com/uploads/${orderItems.product!.imgCover!}',
                ),
              ),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItems.product!.title!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(4),
                Text(
                  '${orderItems.product!.price!} ${trans.egp}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'x${orderItems.quantity}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.pink,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

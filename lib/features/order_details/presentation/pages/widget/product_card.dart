import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orderItems_entity.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.orderItems});
  final OrderItemsEntity orderItems;

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;
    var padding8width = context.width * 0.022;
    var size16height = context.height * 0.016;
    var size44height = context.height * 0.045;
    var size8height = context.height * 0.008;
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
        padding:  EdgeInsets.symmetric(horizontal: padding8width, vertical: padding16width),
        child: Row(
          children: [
            CircleAvatar(
              radius:size44height /2,

              backgroundColor: AppColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: size44height,
                  width: size44height,
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
            horizontalSpace(size8height),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItems.product!.title!,

                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(4),
                Text(
                  '${orderItems.product!.price!} ${trans.egp}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColors.black ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'x${orderItems.quantity}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.pink,
                fontSize: size16height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

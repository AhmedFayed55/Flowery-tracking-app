import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png',
                ),
              ),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Red roses,15 Pink Rose Bouquet',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(4),
                Text(
                  'EGP 250',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'x1',
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

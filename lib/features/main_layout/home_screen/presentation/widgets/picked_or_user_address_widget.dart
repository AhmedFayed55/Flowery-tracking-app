import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class PickedOrUserAddressWidget extends StatelessWidget {
  const PickedOrUserAddressWidget({
    super.key,
    required this.name,
    required this.address,
    required this.image,
  });
  final String name;
  final String address;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.shade100.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  image,
                ),
              ),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    horizontalSpace(4),
                    Text(
                      address,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

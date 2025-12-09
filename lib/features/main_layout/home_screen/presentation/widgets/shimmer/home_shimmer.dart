import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/shimmer/shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  final int itemCount;
  const HomeShimmerWidget({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final BoxDecoration shimmerItemDecoration = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(4),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (_, __) => verticalSpace(16),
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                ShimmerContainer(height: 18, width: 100),
                ShimmerContainer(height: 60, width: double.infinity),
                ShimmerContainer(height: 14, width: 80),
                ShimmerContainer(height: 60, width: double.infinity),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(height: 18, width: 70),
                    ShimmerContainer(height: 35, width: 80),
                    ShimmerContainer(height: 35, width: 80),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

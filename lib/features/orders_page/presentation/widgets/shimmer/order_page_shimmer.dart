import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/shimmer/shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderPageShimmerWidget extends StatelessWidget {
  final int itemCount;
  const OrderPageShimmerWidget({super.key, this.itemCount = 6});

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
      child: Column(
        children: [
          // Horizontal shimmer tabs
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: SizedBox(
              height: screenHeight * 0.05,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => horizontalSpace(12),
                itemBuilder: (context, index) {
                  return Container(
                    height: screenHeight * 0.045,
                    width: screenWidth * 0.25,
                    decoration: shimmerItemDecoration.copyWith(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
              ),
            ),
          ),
          verticalSpace(16),

          Expanded(
            child: ListView.separated(
              itemCount: itemCount,
              separatorBuilder: (_, __) => verticalSpace(16),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: screenHeight * 0.35,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      spacing: 14,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerContainer(height: 18, width: 100),
                        Row(
                          children: [
                            ShimmerContainer(
                              height: 24,
                              width: 24,
                              radius: BorderRadius.circular(12),
                            ),
                            horizontalSpace(8),
                            const ShimmerContainer(height: 18, width: 90),
                            const Spacer(),
                            const ShimmerContainer(height: 18, width: 70),
                          ],
                        ),
                        const ShimmerContainer(height: 14, width: 100),
                        const ShimmerContainer(
                          height: 60,
                          width: double.infinity,
                        ),
                        const ShimmerContainer(height: 14, width: 100),
                        const ShimmerContainer(
                          height: 60,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

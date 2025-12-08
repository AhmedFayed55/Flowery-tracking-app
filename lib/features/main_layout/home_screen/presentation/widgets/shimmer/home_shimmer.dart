import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
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
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 14,
                children: [
                  Container(
                    height: screenHeight * 0.018,
                    width: screenWidth * 0.25,
                    decoration: shimmerItemDecoration,
                  ),
                  Container(
                    height: screenHeight * 0.073,
                    width: double.infinity,
                    decoration: shimmerItemDecoration.copyWith(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  Container(
                    height: screenHeight * 0.013,
                    width: screenWidth * 0.16,
                    decoration: shimmerItemDecoration,
                  ),

                  Container(
                    height: screenHeight * 0.073,
                    width: double.infinity,
                    decoration: shimmerItemDecoration.copyWith(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: screenHeight * 0.018,
                        width: screenWidth * 0.16,
                        decoration: shimmerItemDecoration,
                      ),

                      Container(
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.24,
                        decoration: shimmerItemDecoration.copyWith(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.24,
                        decoration: shimmerItemDecoration.copyWith(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

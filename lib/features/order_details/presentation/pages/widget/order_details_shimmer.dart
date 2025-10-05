import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;
    var size16height = context.height * 0.016;
    var size12height = context.height * 0.012;
    var size32height = context.height * 0.032;
    var size20height = context.height * 0.0199;
    var size60height = context.height * 0.06;
    var size50height = context.height * 0.06;
    var size120height = context.height * 0.12;
    var size80height = context.height * 0.08;
    var size8height = context.height * 0.008;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding16width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status + Order Info
            Container(
              margin: EdgeInsets.symmetric(vertical: size8height),
              height: size60height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            SizedBox(height: size16height),

            // Pickup Address
            Container(
              height: size80height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: size16height),

            // User Address
            Container(
              height: size80height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: size16height),

            // Order Details Title
            Container(
              height: size20height,
              width: size120height,
              color: Colors.white,
            ),

            SizedBox(height: size12height),

            // Product 1
            Container(
              height: size80height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: size12height),

            // Product 2
            Container(
              height: size80height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: size16height),

            // Order Details Title
            Container(
              height: size20height,
              width: size120height,
              color: Colors.white,
            ),

            SizedBox(height: size12height),

            Container(
              height: size50height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: size12height),

            // Product 2
            Container(
              height: size80height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(height: size16height),

            // Total
            Container(
              height: size50height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const Spacer(),

            // Button
            Container(
              height: size50height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: size32height),
          ],
        ),
      ),
    );
  }
}
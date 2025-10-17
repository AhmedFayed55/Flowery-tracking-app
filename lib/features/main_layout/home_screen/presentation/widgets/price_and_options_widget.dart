import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/font_weight.dart';
import 'package:flutter/material.dart';

class PriceAndOptionsWidget extends StatelessWidget {
  const PriceAndOptionsWidget({
    super.key,
    required this.price,
    required this.rejectOnTap,
    required this.acceptOnTap,
  });
  final num price;
  final void Function() rejectOnTap;
  final void Function() acceptOnTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final screenHeight = context.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EGP $price",
          style: context.textTheme.titleSmall!.copyWith(
            fontWeight: AppFontWeight.bold,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: rejectOnTap,
          child: Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.04,
            // padding: const EdgeInsets.symmetric(horizontal: 34.5, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: context.colorScheme.primary),
            ),
            child: Center(
              child: Text(
                context.localization.reject,
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: acceptOnTap,
          child: Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.04,
            // padding: const EdgeInsets.symmetric(horizontal: 34.5, vertical: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: context.colorScheme.primary),
            ),
            child: Center(
              child: Text(
                context.localization.accept,
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

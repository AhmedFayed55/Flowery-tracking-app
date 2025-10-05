import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    required this.firstText,
    required this.secondText,
    super.key,
  });
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;
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
        padding:  EdgeInsets.all(padding16width),
        child: Row(
          children: [
            Text(firstText, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            Text(
              secondText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
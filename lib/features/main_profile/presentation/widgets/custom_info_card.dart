import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String? firstText;
  final String? middleText;
  final String? lastText;
  final IconData? iconDataTrailing;
  final Widget? leading;
  final double? horizontalSpacing;
  final VoidCallback? onClick;

  const CustomInfoCard({
    super.key,
    this.firstText,
    this.middleText,
    this.lastText,
    this.leading,
    this.iconDataTrailing,
    this.horizontalSpacing,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * .13,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Row(
        children: [
          if (leading != null) Expanded(flex: 2, child: leading!),
          if (horizontalSpacing != null) horizontalSpace(horizontalSpacing!),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (firstText != null)
                  Text(
                    overflow: TextOverflow.ellipsis,
                    firstText!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                if (middleText != null)
                  Text(
                    overflow: TextOverflow.ellipsis,
                    middleText!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 16),
                  ),
                if (lastText != null)
                  Text(
                    overflow: TextOverflow.ellipsis,
                    lastText!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 16),
                  ),
              ],
            ),
          ),
          if (iconDataTrailing != null)
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                if(onClick != null){
                  onClick!();
                }
                },
                icon: Icon(iconDataTrailing!, size: 24),
              ),
            ),
        ],
      ),
    );
  }
}

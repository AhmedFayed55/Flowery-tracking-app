import 'package:flutter/material.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';

class CustomActionRow extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Widget? trailing;

  const CustomActionRow({super.key, this.icon, this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon!, size: 24),
        horizontalSpace(4),
        if (title != null)
          Text(title!, style: Theme.of(context).textTheme.displaySmall),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

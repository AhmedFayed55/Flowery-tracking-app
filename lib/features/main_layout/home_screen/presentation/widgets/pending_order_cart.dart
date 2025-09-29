import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class PendingOrderCart extends StatelessWidget {
  const PendingOrderCart ({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 3),
            blurRadius: 3.0,
            spreadRadius: 0.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        spacing: 16,
        children: [
          Text(context.localization.flower_order,style: theme.textTheme.bodyMedium!.copyWith(
            color: Color(0xff0C1015)
          ),),

        ],
      ),
    );
  }
}

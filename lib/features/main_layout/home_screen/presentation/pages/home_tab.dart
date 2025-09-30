import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/font_weight.dart';
import 'package:flutter/material.dart';
import '../widgets/pending_order_cart.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.flowery_rider,style: context.textTheme.bodyLarge!.copyWith(
          fontWeight: AppFontWeight.regular,
          color: AppColors.pink
        ),),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 29),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => const PendingOrderCart(),
                  separatorBuilder: (context, index) => verticalSpace(16),
                  itemCount: 7),
            ),
          ],
        ),
      ),
    );
  }
}



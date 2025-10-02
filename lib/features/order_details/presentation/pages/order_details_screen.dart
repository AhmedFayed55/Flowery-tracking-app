import 'dart:developer';

import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart' hide OrderStatus;
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/call_card.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_status.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),

        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.shade100.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () async {
              // var result = await getIt<OrderDetailsRepo>().updateOrderStatus(
              //   '154545',
              //   'pending',
              // );
              // switch (result) {
              //   case FirebaseSuccessResult():
              //     log('success');
              //     break;
              //   case FirebaseErrorResult():
              //     log('error: ${result.failure.errorMessage} ');
              // }
            },

            child: Text(
              'Arrived at Pickup point',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Order Details'),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepProgressIndicator(
                padding: 4,

                roundedEdges: Radius.circular(3),
                totalSteps: 5,
                currentStep: 1,
                selectedColor: AppColors.green,
              ),
              verticalSpace(24),

              const OrderStatus(),

              verticalSpace(16),
              Text(
                'Pickup address',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(16),
              const CallCard(phoneNumber: '201011472310'),
              verticalSpace(24),
              Text(
                'User address',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(16),
              const CallCard(phoneNumber: '201011472310'),
              verticalSpace(24),
              Text(
                'Order details',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(16),
              const ProductCard(),
              verticalSpace(16),
              const ProductCard(),
              verticalSpace(24),
              const DetailsWidget(firstText: 'Total', secondText: 'EGP 3000'),
              verticalSpace(16),
              const DetailsWidget(
                firstText: 'Payment method',
                secondText: 'Cash on delivery',
              ),
              verticalSpace(8),
            ],
          ),
        ),
      ),
    );
  }
}

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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(firstText, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            Text(
              secondText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

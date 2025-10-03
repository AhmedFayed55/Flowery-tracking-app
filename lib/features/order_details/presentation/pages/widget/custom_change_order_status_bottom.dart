import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomChangeOrderStatusBottom extends StatelessWidget {
  const CustomChangeOrderStatusBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderDetailsCubit>().state;
    return Container(
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
          onPressed: state.riderOrderStatus == RiderOrderStatus.delivered
              ? null
              : () {
                  final orderId = context
                      .read<OrderDetailsCubit>()
                      .state
                      .orderDetails
                      ?.id;
                  if (orderId != null) {
                    context.read<OrderDetailsCubit>().doIntent(
                      ChangeToNextStatusEvent(orderId: orderId),
                    );
                  }
                },
          child: state.isUpdating || state.riderOrderStatus == null
              ? const CircularProgressIndicator(color: AppColors.white)
              : Text(
                  state.riderOrderStatus!.nextStatusButto,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

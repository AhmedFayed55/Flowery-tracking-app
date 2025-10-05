import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomChangeOrderStatusBottom extends StatelessWidget {
  const CustomChangeOrderStatusBottom({super.key});

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;
    var padding32width = context.width * 0.07;
    var size56height = context.height * 0.057;

    final state = context.watch<OrderDetailsCubit>().state;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding16width,
        vertical: padding32width,
      ),

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
        height: size56height,
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
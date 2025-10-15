import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class OrderStateModel {
  String state;
  Widget icon;

  OrderStateModel({required this.state, required this.icon});

  static List<OrderStateModel> getOrderStates() {
    return [
      OrderStateModel(
        state: AppConstants.cancelled,
        icon: const Icon(Icons.cancel_outlined, color: AppColors.red, size: 24),
      ),
      OrderStateModel(
        state: AppConstants.completed,
        icon: const Icon(
          Icons.check_circle_outline,
          color: AppColors.green,
          size: 24,
        ),
      ),
      OrderStateModel(
        state: AppConstants.inProgress,
        icon: const Icon(Icons.pending, color: Colors.yellow, size: 24),
      ),
    ];
  }
}

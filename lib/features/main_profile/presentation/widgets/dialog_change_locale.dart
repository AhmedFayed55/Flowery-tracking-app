import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_tracking_app/core/general_cubits/locale_cubit.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';

class DialogChangeLocale extends StatelessWidget {
  const DialogChangeLocale({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          verticalSpace(16),

          ///changeLanguage
          Text(
            context.localization.change_language,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.pink,
              fontSize: 20,
            ),
          ),
          verticalSpace(16),

          ///isEnglish
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 3),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.localization.english,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                GestureDetector(
                  onTap: () {
                    if (localeCubit.state.languageCode != AppConstants.enKey) {
                      context.read<LocaleCubit>().changeLocale();
                    }
                    context.pop();
                  },
                  child: localeCubit.state.languageCode == AppConstants.enKey
                      ? const Icon(Icons.check_box, color: AppColors.pink)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ],
            ),
          ),
          verticalSpace(16),

          ///isArabic
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 3),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.localization.arabic,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                GestureDetector(
                  onTap: () {
                    if (localeCubit.state.languageCode != AppConstants.arKey) {
                      context.read<LocaleCubit>().changeLocale();
                    }
                    context.pop();
                  },
                  child: localeCubit.state.languageCode == AppConstants.arKey
                      ? const Icon(Icons.check_box, color: AppColors.pink)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

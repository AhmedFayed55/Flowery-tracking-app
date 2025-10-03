import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BuildGenderField extends StatelessWidget {
  final String selectedGender;

  const BuildGenderField({super.key, required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    final space = context.width * 0.05;

    return Row(
      children: [
        Text(
          context.localization.gender,
          style: context.textTheme.bodyLarge!.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
        SizedBox(width: space),
        GenderOption(
          value: AppConstants.female,
          groupValue: selectedGender,
          label: context.localization.female_label,
          activeColor: AppColors.pink,
        ),
        SizedBox(width: space),
        GenderOption(
          value: AppConstants.male,
          groupValue: selectedGender,
          label: context.localization.male_label,
          activeColor: AppColors.blue,
        ),
      ],
    );
  }
}

class GenderOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final String label;
  final Color activeColor;

  const GenderOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          // ignore: deprecated_member_use
          groupValue: groupValue,
          // ignore: deprecated_member_use
          onChanged: (_) {},
          activeColor: activeColor,
        ),
        Text(label, style: context.textTheme.titleMedium),
      ],
    );
  }
}

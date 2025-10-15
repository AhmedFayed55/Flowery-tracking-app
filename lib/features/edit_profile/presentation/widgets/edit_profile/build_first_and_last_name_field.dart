import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flutter/material.dart';

class BuildFirstAndLastNameField extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;

  const BuildFirstAndLastNameField({
    super.key,
    required this.firstNameController,
    required this.secondNameController,
  });

  @override
  Widget build(BuildContext context) {
    final space = context.width * 0.04;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: firstNameController,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: context.localization.first_name,
              hintText: context.localization.enter_first_name,
            ),
            validator: (value) => Validations.validateName(context, value),
          ),
        ),
        SizedBox(width: space),
        Expanded(
          child: TextFormField(
            controller: secondNameController,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: context.localization.last_name,
              hintText: context.localization.enter_last_name,
            ),
            validator: (value) => Validations.validateName(context, value),
          ),
        ),
      ],
    );
  }
}

import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flutter/material.dart';

class BuildPhoneField extends StatelessWidget {
  final TextEditingController controller;
  const BuildPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: context.textTheme.bodyMedium,

      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      decoration: InputDecoration(
        labelText: context.localization.phone_number,
        hintText: context.localization.enter_phone_number,
        labelStyle: context.textTheme.titleMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) =>
          Validations.validateInternationalPhoneNumber(context, value),
    );
  }
}

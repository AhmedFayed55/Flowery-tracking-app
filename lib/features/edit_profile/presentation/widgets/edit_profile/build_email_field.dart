import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  final TextEditingController controller;
  const BuildEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: context.textTheme.bodyMedium,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: context.localization.email,
        labelStyle: context.textTheme.titleMedium,
        hintText: context.localization.enter_your_email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) => Validations.validateEmail(context, value),
    );
  }
}

import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {
  final VoidCallback onChangePressed;

  const BuildPasswordField({super.key, required this.onChangePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: TextEditingController(
              text: AppConstants.passwordCharacters,
            ),
            readOnly: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: context.localization.password,
              labelStyle: context.textTheme.titleMedium,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: TextButton(
                onPressed: onChangePressed,
                child: Text(
                  context.localization.change,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

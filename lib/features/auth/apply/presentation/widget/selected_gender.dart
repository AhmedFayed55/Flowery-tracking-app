import 'package:flutter/material.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/enum_gender.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';

class GenderSelectorWidget extends StatefulWidget {
  final Genders selectedGender;
  final void Function(Genders) onChanged;

  const GenderSelectorWidget({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  State<GenderSelectorWidget> createState() => _GenderSelectorWidgetState();
}

class _GenderSelectorWidgetState extends State<GenderSelectorWidget> {
  late Genders selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          AppLocalizations.of(context)!.gender,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        RadioMenuButton<Genders>(
          value: Genders.male,
          groupValue: selectedGender,
          onChanged: (gender) {
            if (gender != null) {
              setState(() {
                selectedGender = gender;
              });
              widget.onChanged(gender);
            }
          },
          child: Text(AppLocalizations.of(context)!.male),
        ),
        const SizedBox(width: 16),
        RadioMenuButton<Genders>(
          value: Genders.female,
          groupValue: selectedGender,
          onChanged: (gender) {
            if (gender != null) {
              setState(() {
                selectedGender = gender;
              });
              widget.onChanged(gender);
            }
          },
          child: Text(AppLocalizations.of(context)!.female),
        ),
      ],
    );
  }
}

// presentation/widgets/gender_selector_widget.dart
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/enum_gender.dart';
import 'package:flutter/material.dart';

class GenderSelectorWidget extends StatefulWidget {
  final Genders? initialGender;
  final void Function(Genders) onChanged;

  const GenderSelectorWidget({
    super.key,
    this.initialGender,
    required this.onChanged,
  });

  @override
  _GenderSelectorWidgetState createState() => _GenderSelectorWidgetState();
}

class _GenderSelectorWidgetState extends State<GenderSelectorWidget> {
  late Genders _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender ?? Genders.male;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Gender", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<Genders>(
                value: Genders.male,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                  widget.onChanged(_selectedGender);
                },
              ),
              const Text("Male", style: TextStyle(color: Colors.black)),
              const SizedBox(width: 16),
              Radio<Genders>(
                value: Genders.female,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                  widget.onChanged(_selectedGender);
                },
              ),
              const Text("Female", style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}

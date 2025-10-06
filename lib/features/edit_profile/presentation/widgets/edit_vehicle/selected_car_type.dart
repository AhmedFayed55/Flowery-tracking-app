import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';
import 'package:flutter/material.dart';

class SelectedCarTextField extends StatefulWidget {
  final void Function(String carId) onCarSelected;
  final List<VehicleEntity> cars;

  const SelectedCarTextField({
    super.key,
    required this.onCarSelected,
    required this.cars,
  });

  @override
  State<SelectedCarTextField> createState() => _SelectedCarTextFieldState();
}

class _SelectedCarTextFieldState extends State<SelectedCarTextField> {
  VehicleEntity? _selectedCar;

  void _showCarBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final mq = MediaQuery.of(context);
        return Container(
          height: mq.size.height * 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.select_car,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: AppColors.pink),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cars.length,
                  itemBuilder: (context, index) {
                    final car = widget.cars[index];
                    return ListTile(
                      title: Text(car.type),
                      trailing: Image.network(
                        car.image,
                        width: mq.size.width * 0.15,
                        height: mq.size.width * 0.15,
                      ),
                      onTap: () {
                        setState(() => _selectedCar = car);
                        widget.onCarSelected(car.id);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: _showCarBottomSheet,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: context.localization.car,
            hintText: _selectedCar?.type ?? context.localization.select_car,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: mq.size.width * 0.07,
            ),
          ),
        ),
      ),
    );
  }
}

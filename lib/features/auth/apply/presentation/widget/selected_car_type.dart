import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:flutter/material.dart';

class SelectedCarTextField extends StatefulWidget {
  final void Function(String carId) onCarSelected;
  final List<VehicelEntity> cars;

  const SelectedCarTextField({
    super.key,
    required this.onCarSelected,
    required this.cars,
  });

  @override
  State<SelectedCarTextField> createState() => _SelectedCarTextFieldState();
}

class _SelectedCarTextFieldState extends State<SelectedCarTextField> {
  VehicelEntity? _selectedCar;

  void _showCarBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Select Car',
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
                      trailing: Image.network(car.image, width: 50, height: 50),
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
    return GestureDetector(
      onTap: _showCarBottomSheet,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Car',
            hintText: _selectedCar?.type ?? 'Select Car',
            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp, size: 30),
          ),
        ),
      ),
    );
  }
}

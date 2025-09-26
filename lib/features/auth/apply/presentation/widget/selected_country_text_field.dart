import 'package:country_picker/country_picker.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class SelectedCountryTextField extends StatefulWidget {
  final void Function(String countryName,String countryCode ) onCountrySelected;

  const SelectedCountryTextField({super.key, required this.onCountrySelected});

  @override
  State<SelectedCountryTextField> createState() =>
      _SelectedCountryTextFieldState();
}

class _SelectedCountryTextFieldState extends State<SelectedCountryTextField> {
  Country? _selectedCountry;

  void _selectCountry() {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
        textStyle: const TextStyle(color: AppColors.red),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      context: context,
      showPhoneCode: true,
      onSelect: (country) {
        setState(() => _selectedCountry = country);
        widget.onCountrySelected(country.name, '+${country.phoneCode}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectCountry,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Country',
            hintText: _selectedCountry?.name ?? 'Select Country',
            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp, size: 30),
          ),
        ),
      ),
    );
  }
}

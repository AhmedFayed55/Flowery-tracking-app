import 'dart:io';

import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/enum_gender.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  final ApplyViewModel cubit;
  final GlobalKey<FormState> formKey;
  final String selectedCountryName;
  final String countryCodeEntity;
  final String carId;
  final File? licenseImage;
  final File? idImage;
  final Genders selectedGender;
  const ApplyButton({
    super.key,
    required this.cubit,
    required this.formKey,
    required this.selectedCountryName,
    required this.countryCodeEntity,
    required this.carId,
    required this.licenseImage,
    required this.idImage,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String rawPhone = cubit.phoneController.text.trim();
          if (rawPhone.startsWith('0')) {
            rawPhone = rawPhone.substring(1);
          }
          if (licenseImage == null || idImage == null) {
      // لو أي صورة ناقصة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload both license and ID images')),
      );
      return;
    }
          cubit.doIntent(
            ApplyDriverEvent(
              RequestApplyEntity(
                country: selectedCountryName,
                firstName: cubit.firstNameController.text.trim(),
                lastName: cubit.lastNameController.text.trim(),
                vehicleType: carId,
                vehicleNumber: cubit.carNumberController.text.trim(),
                vehicleLicense: licenseImage!,
                nID: cubit.idNumberController.text.trim(),
                nIDImg: idImage!,
                email: cubit.emailController.text.trim(),
                gender: selectedGender.toString().split('.').last,
                phone: '$countryCodeEntity$rawPhone',
                password: cubit.passwordController.text.trim(),
                rePassword: cubit.confirmPasswordController.text.trim(),
              ),
            ),
          );
        }
      },
      child: Text(AppLocalizations.of(context)!.apply),
    );
  }
}

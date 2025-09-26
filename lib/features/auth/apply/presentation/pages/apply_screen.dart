import 'dart:io';
import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/helpers/flutter_toast.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/enum_gender.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/image_paker_field.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_car_type.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_country_text_field.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  File? idImage;
  File? licenseImage;
  String selectedCountryName = '';
  String carId = '';
  String countryCodeEntity = '';
  Genders selectedGender = Genders.male;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplyViewModel>(
      create: (context) =>
          getIt<ApplyViewModel>()..doIntent(GetVehiclesEvent()),
      child: BlocListener<ApplyViewModel, ApplyState>(
        listener: (context, state) {
          if (state.isLoading) {
            DialogueUtils.showLoading(context: context, message: 'Loading...');
          }
          //else {
          //   DialogueUtils.hideLoading(context);
          // }

          if (state.errorMessage.isNotEmpty) {
            DialogueUtils.hideLoading(context);
            DialogueUtils.showAlertDialog(context, state.errorMessage);
          }

          if (state.driver != null) {
            DialogueUtils.hideLoading(context);
            ToastMessage.toastMsg('Applied successfully');

           // context.pushNamed(AppRoutes)
          }          

        },
        child: Builder(
          builder: (context) {
            final cubit = context.read<ApplyViewModel>();

            return Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Welcome!!', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 10),
                        SelectedCountryTextField(
                          onCountrySelected: (countryName, countryCode) {
                            selectedCountryName = countryName;
                            countryCodeEntity = countryCode;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.firstNameController,
                          validator: (value) =>
                              Validations.validateName(context, value),
                          decoration: const InputDecoration(
                            labelText: 'First legal name',
                            hintText: 'Enter first legal name',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.lastNameController,
                          validator: (value) =>
                              Validations.validateName(context, value),
                          decoration: const InputDecoration(
                            labelText: 'Last legal name',
                            hintText: 'Enter last legal name',
                          ),
                        ),
                        const SizedBox(height: 10),

                        BlocBuilder<ApplyViewModel, ApplyState>(
                          buildWhen: (previous, current) =>
                              previous.vehicelEntity != current.vehicelEntity,
                          builder: (context, state) {
                            final vehicles = state.vehicelEntity ?? [];
                            return SelectedCarTextField(
                              cars: vehicles,
                              onCarSelected: (id) => carId = id,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.carNumberController,
                          validator: (value) =>
                              Validations.validateRequired(context, value),
                          decoration: const InputDecoration(
                            labelText: 'Vehicle number',
                            hintText: 'Enter vehicle number',
                          ),
                        ),
                        const SizedBox(height: 10),
                        ImageField(
                          label: 'License image',
                          hint: 'Upload license image',
                          onImagePicked: (image) => licenseImage = image,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter email',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                            hintText: 'Enter phone number',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cubit.idNumberController,
                          decoration: const InputDecoration(
                            labelText: 'ID number',
                            hintText: 'Enter ID number',
                          ),
                        ),
                        const SizedBox(height: 10),
                        ImageField(
                          label: 'ID image',
                          hint: 'Upload ID image',
                          onImagePicked: (imageid) => idImage = imageid,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: cubit.passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter password',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: cubit.confirmPasswordController,
                                validator: (value) =>
                                    Validations.confirmPassword(context, value),
                                decoration: const InputDecoration(
                                  labelText: 'Confirm password',
                                  hintText: 'Confirm password',
                                ),
                              ),
                            ),
                          ],
                        ),
                        GenderSelectorWidget(
                          onChanged: (gender) {
                            selectedGender = gender;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String rawPhone = cubit.phoneController.text
                                  .trim();
                              if (rawPhone.startsWith('0')) {
                                rawPhone = rawPhone.substring(1);
                              }
                              cubit.doIntent(
                                ApplyDriverEvent(
                                  RequestApplyEntity(
                                    country: selectedCountryName,
                                    firstName: cubit.firstNameController.text
                                        .trim(),
                                    lastName: cubit.lastNameController.text
                                        .trim(),
                                    vehicleType: carId,
                                    vehicleNumber: cubit
                                        .carNumberController
                                        .text
                                        .trim(),
                                    vehicleLicense: licenseImage!,
                                    nID: cubit.idNumberController.text.trim(),
                                    nIDImg: idImage!,
                                    email: cubit.emailController.text.trim(),
                                    gender: selectedGender
                                        .toString()
                                        .split('.')
                                        .last,
                                    phone: '$countryCodeEntity$rawPhone',

                                    password: cubit.passwordController.text
                                        .trim(),
                                    rePassword: cubit
                                        .confirmPasswordController
                                        .text
                                        .trim(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

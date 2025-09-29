import 'dart:io';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/helpers/flutter_toast.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/enum_gender.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/app_bar_apply.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/apply_button.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/contact_fields.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/id_fields.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/name_fields.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/password_fields.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_country_text_field.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_gender.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/vehicel_fields.dart';
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
            DialogueUtils.showLoading(
              context: context,
              message: AppLocalizations.of(context)!.loading,
            );
          }

          if (state.errorMessage.isNotEmpty) {
            DialogueUtils.hideLoading(context);
            DialogueUtils.showAlertDialog(context, state.errorMessage);
          }

          if (state.driver != null) {
            DialogueUtils.hideLoading(context);
            ToastMessage.toastMsg(
              AppLocalizations.of(context)!.applied_successfully,
            );

            // context.pushNamed(AppRoutes)
          }
        },
        child: Builder(
          builder: (context) {
            final cubit = context.read<ApplyViewModel>();
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.apply),
                scrolledUnderElevation: 0,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppBarApply(),

                          SelectedCountryTextField(
                            onCountrySelected: (countryName, countryCode) {
                              selectedCountryName = countryName;
                              countryCodeEntity = countryCode;
                            },
                          ),
                          NameFields(cubit: cubit),
                          VehicelFields(
                            onCarSelected: (id) => carId = id,
                            cubit: cubit,
                            onLicensePicked: (image) {
                              setState(() {
                                licenseImage = image;
                              });
                            },
                          ),
                          ContactFields(cubit: cubit),
                          IdFields(
                            cubit: cubit,
                            onImageIdPicked: (imageId) => setState(() {
                              idImage = imageId;
                            }),
                          ),

                          PasswordFields(cubit: cubit),
                          GenderSelectorWidget(
                            selectedGender: selectedGender,
                            onChanged: (Genders p1) {
                              selectedGender = p1;
                            },
                          ),
                          ApplyButton(
                            cubit: cubit,
                            formKey: _formKey,
                            selectedCountryName: selectedCountryName,
                            countryCodeEntity: countryCodeEntity,
                            carId: carId,
                            licenseImage: licenseImage,
                            idImage: idImage,
                            selectedGender: selectedGender,
                          ),
                        ],
                      ),
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

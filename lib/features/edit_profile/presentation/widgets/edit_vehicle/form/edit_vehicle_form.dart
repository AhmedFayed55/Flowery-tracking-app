import 'dart:io';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/helpers/flutter_toast.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/core/utils/custom_elevated_button.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/vehicel_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditVehicleForm extends StatefulWidget {
  const EditVehicleForm({super.key});

  @override
  State<EditVehicleForm> createState() => _EditVehicleFormState();
}

class _EditVehicleFormState extends State<EditVehicleForm> {
  File? licenseImage;
  String carId = '';
  final _formKey = GlobalKey<FormState>();
  late final VehicleViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<VehicleViewModel>();
    viewModel.doIntent(GetVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final spaceSmall = context.height * 0.01;
    final spaceMed = context.height * 0.02;
    final horizontalPadding = context.width * 0.05;

    return BlocListener<VehicleViewModel, VehicleState>(
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
          ToastMessage.toastMsg(context.localization.update_successfully);
        }
      },
      child: Builder(
        builder: (context) {
          final cubit = context.read<VehicleViewModel>();
          return Scaffold(
            appBar: AppBar(
              title: Text(context.localization.edit_profile),
              scrolledUnderElevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: spaceSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VehicelFields(
                          onCarSelected: (id) => carId = id,
                          cubit: cubit,
                          onLicensePicked: (image) {
                            setState(() {
                              licenseImage = image;
                            });
                          },
                        ),
                        SizedBox(height: spaceMed),

                        CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          isLoading: false,
                          widget: Text(context.localization.update),
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
    );
  }
}

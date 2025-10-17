import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/form/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<EditProfileViewModel>()..doIntend(GetLoggedUserDataEvent()),
      child: const EditProfileForm(),
    );
  }
}

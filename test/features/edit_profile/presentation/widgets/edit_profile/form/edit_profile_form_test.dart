import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/form/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_form_test.mocks.dart';

@GenerateMocks([EditProfileViewModel])
void main() {
  testWidgets(
    'EditProfileForm dispatches LoadUserData on init and submit on tap',
    (tester) async {
      final mockVm = MockEditProfileViewModel();

      when(mockVm.state).thenReturn(const EditProfileState());
      when(
        mockVm.stream,
      ).thenAnswer((_) => const Stream<EditProfileState>.empty());

      final key = GlobalKey<FormState>();
      when(mockVm.editProfileFormKey).thenReturn(key);
      when(
        mockVm.editProfileFirstNameController,
      ).thenReturn(TextEditingController());
      when(
        mockVm.editProfileLastNameController,
      ).thenReturn(TextEditingController());
      when(
        mockVm.editProfileEmailController,
      ).thenReturn(TextEditingController());
      when(
        mockVm.editProfilePhoneController,
      ).thenReturn(TextEditingController());
      when(mockVm.initialImage).thenReturn(null);
      when(mockVm.doIntend(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<EditProfileViewModel>.value(
            value: mockVm,
            child: const EditProfileForm(),
          ),
        ),
      );

      verify(mockVm.doIntend(argThat(isA<LoadUserDataEvent>()))).called(1);

      await tester.pump();
    },
  );
}

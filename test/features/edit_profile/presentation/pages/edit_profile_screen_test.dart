import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_screen_test.mocks.dart';

@GenerateMocks([EditProfileViewModel])
void main() {
  testWidgets('renders EditProfileScreen using DI and builds successfully', (
    tester,
  ) async {
    final mockVm = MockEditProfileViewModel();
    await getIt.reset();
    getIt.registerFactory<EditProfileViewModel>(() => mockVm);

    when(mockVm.state).thenReturn(const EditProfileState());
    when(
      mockVm.stream,
    ).thenAnswer((_) => const Stream<EditProfileState>.empty());

    // stub controllers and form key used in the form
    final key = GlobalKey<FormState>();
    final first = TextEditingController();
    final last = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();

    when(mockVm.editProfileFormKey).thenReturn(key);
    when(mockVm.editProfileFirstNameController).thenReturn(first);
    when(mockVm.editProfileLastNameController).thenReturn(last);
    when(mockVm.editProfileEmailController).thenReturn(email);
    when(mockVm.editProfilePhoneController).thenReturn(phone);
    when(mockVm.initialImage).thenReturn(null);

    when(mockVm.doIntend(any)).thenAnswer((_) async {});

    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: EditProfileScreen(),
      ),
    );

    expect(find.byType(EditProfileScreen), findsOneWidget);
  });
}

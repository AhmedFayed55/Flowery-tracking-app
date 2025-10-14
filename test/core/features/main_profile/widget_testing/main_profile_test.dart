import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/general_cubits/locale_cubit.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_view_model.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/pages/main_profile.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_action_row.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_info_card.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dialog_change_locale_test.mocks.dart';

@GenerateMocks([ProfileCubit, LocaleCubit])
void main() {
  late ProfileCubit mockProfileCubit;
  late LocaleCubit mockLocaleCubit;
  late AppLocalizations localization;

  Widget buildMainProfile() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => mockLocaleCubit),
          BlocProvider(create: (_) => mockProfileCubit),
        ],
        child: const MainProfile(),
      ),
    );
  }

  setUpAll(() async {
    localization = await AppLocalizations.delegate.load(const Locale('en'));
    mockProfileCubit = MockProfileCubit();
    mockLocaleCubit = MockLocaleCubit();

    when(mockLocaleCubit.state).thenReturn(const Locale('en'));
    when(mockLocaleCubit.stream)
        .thenAnswer((_) => Stream.value(const Locale('en')));

    when(mockProfileCubit.state).thenReturn(ProfileState());
    when(mockProfileCubit.stream)
        .thenAnswer((_) => Stream.value(ProfileState()));

    if (!getIt.isRegistered<ProfileCubit>()) {
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    } else {
      getIt.unregister<ProfileCubit>();
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    }
  });

  group('MainProfile UI Tests', () {
    testWidgets('Verify main_profile structure correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildMainProfile());
      expect(find.text(localization.profile), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(3));
      expect(find.byType(Icon), findsNWidgets(7));
      expect(find.byType(Badge), findsNWidgets(1));
      expect(find.byType(CustomInfoCard), findsNWidgets(2));
      expect(find.byType(CustomActionRow), findsNWidgets(1));
      expect(find.byType(LogoutButton), findsNWidgets(1));
      expect(find.text(localization.language), findsOneWidget);
      expect(find.text(localization.english), findsOneWidget);
      expect(find.text(localization.logout), findsOneWidget);
      expect(find.text(localization.app_version), findsOneWidget);
    });
  });
}

import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/general_cubits/locale_cubit.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_cubit.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/dialog_change_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dialog_change_locale_test.mocks.dart';
import 'main_profile_test.mocks.dart';

@GenerateMocks([ProfileCubit, LocaleCubit, SharedPrefHelper])
void main() {
  late MockProfileCubit mockProfileCubit;
  late MockLocaleCubit mockLocaleCubit;
  late AppLocalizations localization;

  Widget buildMainProfile() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
          BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
        ],
        child: const DialogChangeLocale(),
      ),
    );
  }

  setUpAll(() async {
    localization = await AppLocalizations.delegate.load(const Locale('en'));
    mockProfileCubit = MockProfileCubit();
    mockLocaleCubit = MockLocaleCubit();

    when(mockProfileCubit.state).thenReturn(ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.value(ProfileState()));

    when(mockLocaleCubit.state).thenReturn(const Locale('en'));
    when(
      mockLocaleCubit.stream,
    ).thenAnswer((_) => Stream.value(const Locale('en')));

    if (!getIt.isRegistered<ProfileCubit>()) {
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    } else {
      getIt.unregister<ProfileCubit>();
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    }
  });

  group('DialogChangeLocale UI Tests', () {
    testWidgets('Verify DialogChangeLocale structure correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildMainProfile());
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.text(localization.arabic), findsOneWidget);
      expect(find.text(localization.english), findsOneWidget);
      expect(find.text(localization.change_language), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(2));
      expect(find.byType(GestureDetector), findsNWidgets(2));
    });
  });
}

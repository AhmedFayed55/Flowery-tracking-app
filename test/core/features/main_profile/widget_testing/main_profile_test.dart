import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_view_model.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/pages/main_profile.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_action_row.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_profile_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  late MockProfileCubit mockProfileCubit;
  late AppLocalizations localization;

  Widget buildMainProfile() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider(
        create: (_) => mockProfileCubit,
        child: const MainProfile(),
      ),
    );
  }

  setUpAll(() async {
    localization = await AppLocalizations.delegate.load(const Locale('en'));
    mockProfileCubit = MockProfileCubit();

    when(mockProfileCubit.state).thenReturn(ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.value(ProfileState()));

    if (!getIt.isRegistered<ProfileCubit>()) {
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    } else {
      getIt.unregister<ProfileCubit>();
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    }
  });

  group('MainProfile UI Tests', () {
    testWidgets('Verify main_profile structure correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildMainProfile());
      expect(find.text(localization.profile), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(4));
      expect(find.byType(Icon), findsNWidgets(7));
      expect(find.byType(Badge), findsNWidgets(1));
      expect(find.byType(CustomInfoCard), findsNWidgets(2));
      expect(find.byType(CustomActionRow), findsNWidgets(2));
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is IconButton &&
              widget.icon is Icon &&
              (widget.icon as Icon).icon == Icons.logout,
        ),
        findsWidgets,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.notifications_none,
        ),
        findsWidgets,
      );
      expect(
        find.byWidgetPredicate(
              (widget) => widget is Icon && widget.icon == Icons.translate,
        ),
        findsWidgets,
      );
      expect(find.text(localization.language), findsOneWidget);
      expect(find.text(localization.english), findsOneWidget);
      expect(find.text(localization.logout), findsOneWidget);
      expect(find.text(localization.app_version), findsOneWidget);
    });
  });
}

import 'dart:async';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/general_cubits/locale_cubit.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';

import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_view_model.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/pages/loading_to_profile.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/pages/main_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_profile_test.mocks.dart';

@GenerateMocks([ProfileCubit, LocaleCubit])
void main() {
  late MockProfileCubit mockProfileCubit;
  late MockLocaleCubit mockLocaleCubit;

  Widget buildMaterialApp() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
          BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
        ],
        child: const MainProfile(),
      ),
    );
  }

  setUp(() async {
    mockProfileCubit = MockProfileCubit();
    mockLocaleCubit = MockLocaleCubit();
    when(mockLocaleCubit.state).thenReturn(const Locale("en"));
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([ProfileState(isLoading: true)]));
    when(mockProfileCubit.state).thenReturn(ProfileState(isLoading: true));
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.value(ProfileState(isLoading: true)));
    if (!getIt.isRegistered<ProfileCubit>()) {
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    } else {
      getIt.unregister<ProfileCubit>();
      getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
    }
    if (!getIt.isRegistered<LocaleCubit>()) {
      getIt.registerSingleton<LocaleCubit>(mockLocaleCubit);
    } else {
      getIt.unregister<LocaleCubit>();
      getIt.registerSingleton<LocaleCubit>(mockLocaleCubit);
    }
  });

  group("Test MainProfile UI ", () {
    testWidgets("test emit when isLoading --> true", (WidgetTester tester) async {
      /// Arrange
      when(mockLocaleCubit.state).thenReturn(const Locale("en"));
      when(
        mockLocaleCubit.stream,
      ).thenAnswer((_) => Stream.value(const Locale("en")));
      when(mockProfileCubit.state).thenReturn(ProfileState(isLoading: true));
      when(
        mockProfileCubit.stream,
      ).thenAnswer((_) => Stream.fromIterable([ProfileState(isLoading: true)]));
      await tester.pumpWidget(buildMaterialApp());
      await tester.pump();

      /// Assert
      expect(find.byType(LoadingToProfile), findsNWidgets(2));
    });
  });
}

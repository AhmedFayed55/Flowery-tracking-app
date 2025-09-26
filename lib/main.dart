import 'package:flowery_tracking_app/config/theme/app_theme.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/pages/apply_screen.dart';
import 'package:flowery_tracking_app/features/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routing/route_generator.dart';
import 'core/di/di.dart';
import 'core/general_cubits/locale_cubit.dart';
import 'core/l10n/translations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");

  // final geminiApiKey = dotenv.env['GEMINI_API_KEY'];
  // print("GEMINI_API_KEY: $geminiApiKey");

  await configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => getIt<LocaleCubit>(),
      child: const FloweryTrackingApp(),
    ),
  );
}

class FloweryTrackingApp extends StatelessWidget {
  const FloweryTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return MaterialApp(
          locale: Locale(state.languageCode),
          theme: AppTheme.lightTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          // initialRoute: getInitialRoute(),
          home: const MainLayout(),
        );
      },
    );
  }
}

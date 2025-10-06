import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_tracking_app/config/routing/initial_route.dart';
import 'package:flowery_tracking_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routing/initial_route.dart';
import 'config/routing/route_generator.dart';
import 'core/di/di.dart';
import 'core/general_cubits/locale_cubit.dart';
import 'core/l10n/translations/app_localizations.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  await dotenv.load(fileName: ".env");

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
          initialRoute: getInitialRoute(),

        );
      },
    );
  }
}

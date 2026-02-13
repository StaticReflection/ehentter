import 'package:ehentter/core/bloc/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/core/l10n/generated/app_localizations.dart';
import 'package:ehentter/presentation/common/logic/locale/locale_cubit.dart';
import 'package:ehentter/core/router/app_router.dart';
import 'package:ehentter/presentation/common/base/app_theme.dart';
import 'package:ehentter/presentation/common/logic/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => sl()),
        BlocProvider<LocaleCubit>(create: (_) => sl()),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.watch<ThemeCubit>().state;
          final locale = context.watch<LocaleCubit>().state;

          return MaterialApp.router(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

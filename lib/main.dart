import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/l10n/generated/app_localizations.dart';
import 'package:flutter_template/presentation/common/logic/locale/locale_cubit.dart';
import 'package:flutter_template/core/router/app_router.dart';
import 'package:flutter_template/presentation/common/base/app_theme.dart';
import 'package:flutter_template/presentation/common/logic/theme/theme_cubit.dart';

void main() async {
  await initDependencies();

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

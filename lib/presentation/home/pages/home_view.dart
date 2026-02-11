import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/extensions/build_context.dart';
import 'package:flutter_template/presentation/common/base/base_widget.dart';
import 'package:flutter_template/presentation/common/logic/locale/locale_cubit.dart';
import 'package:flutter_template/presentation/common/logic/theme/theme_cubit.dart';
import 'package:flutter_template/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_template/presentation/home/widgets/locale_selector.dart';
import 'package:flutter_template/presentation/home/widgets/theme_mode_selector.dart';

class HomeView extends BaseWidget<HomeBloc, HomeEffect> {
  const HomeView({super.key});

  @override
  Widget buildWidget(BuildContext context, HomeBloc bloc) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.app_title)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() ||
            HomeLoading() => const Center(child: CircularProgressIndicator()),
            HomeLoaded() => Center(
              child: Column(
                spacing: 12,
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Text('hello world'),
                  ElevatedButton(
                    onPressed: () => bloc.add(HomeTest()),
                    child: Text('test'),
                  ),
                  BlocBuilder<LocaleCubit, Locale?>(
                    builder: (context, state) {
                      final localeCubit = context.read<LocaleCubit>();

                      return LocaleSelector(
                        currentLocale: state,
                        onSelected: (locale) {
                          if (locale == null) {
                            localeCubit.useSystemSettings();
                          } else {
                            localeCubit.changeLocale(locale);
                          }
                        },
                      );
                    },
                  ),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, state) {
                      final themeCubit = context.read<ThemeCubit>();

                      return ThemeModeSelector(
                        currentThemeMode: state,
                        onSelected: (themeMode) {
                          if (themeMode != null) {
                            themeCubit.updateTheme(themeMode);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }

  @override
  void onEffect(BuildContext context, HomeEffect effect) {
    if (effect is HomeShowTestMessage) {
      showSnackBar(context, 'test message');
    }
  }
}

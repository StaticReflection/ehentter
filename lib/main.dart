import 'package:bloc/bloc.dart';
import 'package:ehentter/core/bloc/app_bloc_observer.dart';
import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/presentation/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

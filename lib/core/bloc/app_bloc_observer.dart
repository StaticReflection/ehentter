import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/core/logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final ILoggerService logger = sl();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('[Event] in ${bloc.runtimeType}: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i(
      '[Transition] in ${bloc.runtimeType}:\n'
      'From: ${transition.currentState.runtimeType}\n'
      'Next: ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e(
      '[Error] in ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

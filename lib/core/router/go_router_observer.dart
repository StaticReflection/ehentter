import 'package:ehentter/core/logger/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class GoRouterObserver extends NavigatorObserver {
  ILoggerService get _logger => GetIt.I<ILoggerService>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i(
      'GoRouter Push: ${route.settings.name} (from: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i(
      'GoRouter Pop: ${route.settings.name} (back to: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.i(
      'GoRouter Replace: ${newRoute?.settings.name} (was: ${oldRoute?.settings.name})',
    );
  }
}

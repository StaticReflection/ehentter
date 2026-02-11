import 'package:ehentter/presentation/home/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [GoRoute(path: home, builder: (context, state) => HomePage())],
  );
}

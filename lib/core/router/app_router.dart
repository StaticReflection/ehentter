import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/presentation/gallery_detail/pages/gallery_detail_page.dart';
import 'package:ehentter/presentation/home/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const home = '/';
  static const galleryDetail = '/gallery-detail';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => HomePage()),
      GoRoute(
        path: galleryDetail,
        builder: (context, state) {
          final gallerySummary = state.extra as EhGallerySummary;
          return GalleryDetailPage(gallerySummary);
        },
      ),
    ],
  );
}

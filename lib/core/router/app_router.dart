import 'package:ehentter/core/router/go_router_observer.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/presentation/gallery_detail/pages/gallery_detail_page.dart';
import 'package:ehentter/presentation/gallery_reader/pages/gallery_reader_page.dart';
import 'package:ehentter/presentation/gallery_search/pages/gallery_search_page.dart';
import 'package:ehentter/presentation/home/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const home = '/';
  static const galleryDetail = '/gallery-detail';
  static const galleryReader = '/gallery-reader';
  static const gallerySearch = '/gallery-search';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    observers: [GoRouterObserver()],
    routes: [
      GoRoute(path: home, builder: (context, state) => HomePage()),
      GoRoute(
        path: galleryDetail,
        builder: (context, state) {
          final gallerySummary = state.extra as EhGallerySummary;
          return GalleryDetailPage(gallerySummary);
        },
      ),
      GoRoute(
        path: galleryReader,
        builder: (context, state) {
          final galleryId = state.extra as EhGalleryId;
          return GalleryReaderPage(galleryId);
        },
      ),
      GoRoute(
        path: gallerySearch,
        builder: (context, state) => GallerySearchPage(),
      ),
    ],
  );
}

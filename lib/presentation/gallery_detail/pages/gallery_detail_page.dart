import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/domain/entities/eh_gallery_summary.dart';
import 'package:ehentter/presentation/gallery_detail/bloc/gallery_detail_bloc.dart';
import 'package:ehentter/presentation/gallery_detail/pages/gallery_detail_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryDetailPage extends StatelessWidget {
  const GalleryDetailPage(this.gallerySummary, {super.key});

  final EhGallerySummary gallerySummary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryDetailBloc>(
      create: (_) => sl()..add(GalleryDetailInit(gallerySummary)),
      child: GalleryDetailView(),
    );
  }
}

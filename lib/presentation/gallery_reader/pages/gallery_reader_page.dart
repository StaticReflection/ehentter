import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/presentation/gallery_reader/bloc/gallery_reader_bloc.dart';
import 'package:ehentter/presentation/gallery_reader/pages/gallery_reader_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryReaderPage extends StatelessWidget {
  const GalleryReaderPage(this.galleryId, {super.key});

  final EhGalleryId galleryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryReaderBloc>(
      create: (_) => sl()..add(GalleryReaderInit(galleryId)),
      child: GalleryReaderView(),
    );
  }
}

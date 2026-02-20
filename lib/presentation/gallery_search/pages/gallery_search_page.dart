import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/presentation/gallery_search/bloc/gallery_search_bloc.dart';
import 'package:ehentter/presentation/gallery_search/pages/gallery_search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GallerySearchPage extends StatelessWidget {
  const GallerySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GallerySearchBloc>(
      create: (_) => sl()..add(GallerySearchInit()),
      child: GallerySearchView(),
    );
  }
}

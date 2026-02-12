import 'package:ehentter/domain/entities/eh_gallery_tag_namespace.dart';

class EhGalleryTagGroup {
  final EhGalleryTagNamespaces namespace;
  final Set<String> name;

  EhGalleryTagGroup({required this.namespace, required this.name});
}

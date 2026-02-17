import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';

class GetGalleryImageUseCase {
  final EhGalleryRepository _repository;

  GetGalleryImageUseCase(this._repository);

  Future<String> call(String pageUrl) async =>
      await _repository.getGalleryImage(pageUrl);
}

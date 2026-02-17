import 'package:ehentter/domain/entities/eh_gallery_detail.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';

class GetGalleryDetailUseCase {
  final EhGalleryRepository _repository;

  GetGalleryDetailUseCase(this._repository);

  Future<EhGalleryDetail> call(EhGalleryId id, {int pageIndex = 0}) {
    return _repository.getGalleryDetail(id, pageIndex: pageIndex);
  }
}

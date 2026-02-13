import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/repositores/eh_gallery_repository.dart';

class GetGalleryPageInfoUseCase {
  final EhGalleryRepository _repository;

  GetGalleryPageInfoUseCase(this._repository);

  Future<EhGalleryPageInfo> call({String? query, int? nextGid}) async {
    return await _repository.getGalleryPageInfo(query, nextGid: nextGid);
  }
}

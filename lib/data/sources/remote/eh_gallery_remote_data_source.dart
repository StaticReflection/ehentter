import 'package:ehentter/core/network/dio_client.dart';
import 'package:ehentter/data/parsers/eh_gallery_parsers.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:html/dom.dart';

abstract class EhGalleryRemoteDataSource {
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query);
}

class EhGalleryRemoteDataSourceImpl implements EhGalleryRemoteDataSource {
  final DioClient _dioClient;

  final EhGalleryPageParser _ehGalleryPageParser;

  EhGalleryRemoteDataSourceImpl(this._dioClient, this._ehGalleryPageParser);

  @override
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query) async {
    final response = await _dioClient.dio.get(
      '',
      queryParameters: {'f_search': query ?? ''},
    );

    final document = Document.html(response.data);

    return _ehGalleryPageParser(document);
  }
}

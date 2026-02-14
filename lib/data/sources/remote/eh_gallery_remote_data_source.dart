import 'package:ehentter/core/network/dio_client.dart';
import 'package:ehentter/data/models/eh_gallery_detail_model.dart';
import 'package:ehentter/data/parsers/eh_gallery_parsers.dart';
import 'package:ehentter/domain/entities/eh_gallery_id.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:html/dom.dart';

abstract class EhGalleryRemoteDataSource {
  Future<EhGalleryPageInfo> getGalleryPageInfo(String? query, {int? nextGid});

  Future<EhGalleryDetailModel> getGalleryDetail(EhGalleryId id);
}

class EhGalleryRemoteDataSourceImpl implements EhGalleryRemoteDataSource {
  final DioClient _dioClient;

  final EhGalleryPageParser _ehGalleryPageParser;
  final EhGalleryDetailParser _ehGalleryDetailParser;

  EhGalleryRemoteDataSourceImpl(
    this._dioClient,
    this._ehGalleryPageParser,
    this._ehGalleryDetailParser,
  );

  @override
  Future<EhGalleryPageInfo> getGalleryPageInfo(
    String? query, {
    int? nextGid,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'f_search': ?query,
      'next': ?nextGid,
    };

    final response = await _dioClient.dio.get(
      '',
      queryParameters: queryParameters,
    );

    final document = Document.html(response.data);

    return _ehGalleryPageParser(document);
  }

  @override
  Future<EhGalleryDetailModel> getGalleryDetail(EhGalleryId id) async {
    final response = await _dioClient.dio.get('/g/${id.gid}/${id.token}');

    return _ehGalleryDetailParser(Document.html(response.data));
  }
}

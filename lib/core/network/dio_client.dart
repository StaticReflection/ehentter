import 'package:dio/dio.dart';
import 'package:ehentter/core/constants/network_config.dart';

class DioClient {
  final Dio _dio;

  Dio get dio => _dio;

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: NetworkConfig.baseUrl,
      connectTimeout: NetworkConfig.connectTimeout,
      receiveTimeout: NetworkConfig.receiveTimeout,
    );
  }
}

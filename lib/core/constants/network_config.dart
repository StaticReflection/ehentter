class NetworkConfig {
  NetworkConfig._();

  static const String baseUrl = 'https://www.example.com';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}

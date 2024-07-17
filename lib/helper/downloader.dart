import 'dart:typed_data';
import 'package:dio/dio.dart';

class ImageDownloader {
  final String baseUrl;
  final Map<String, String>? authHeader;
  final String imagePath;

  ImageDownloader(
      {required this.baseUrl,
      required this.authHeader,
      required this.imagePath});

  /// Configures and returns a Dio instance with the necessary headers.
  Dio _getDioInstance() {
    Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: authHeader,
      responseType: ResponseType.bytes, // Ensure we get the response as bytes
    ));
    dio.interceptors.add(LogInterceptor(
        responseBody: false)); // Optional: Add logging for debugging
    return dio;
  }

  /// Makes the HTTP request to download the image data.
  Future<Uint8List> _fetchImageData() async {
    Dio dio = _getDioInstance();
    try {
      Response response = await dio.get(imagePath);
      if (response.statusCode == 200) {
        return response.data as Uint8List;
      } else {
        throw Exception(
            'Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to download image: $e');
    }
  }

  /// Public method to coordinate the image download process.
  Future<Uint8List> downloadImage() async {
    try {
      return await _fetchImageData();
    } catch (e) {
      // You can add additional logging or error handling here
      rethrow;
    }
  }
}

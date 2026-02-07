import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/data/models/photo_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://api.unsplash.com';
    _dio.options.headers['Authorization'] =
        'Client-ID api _key';
  }

  Future<List<PhotoModel>> getPhotos() async {
    try {
      // Using Unsplash API
      final response = await _dio.get(
        '/photos',
        queryParameters: {'per_page': 30, 'order_by': 'popular'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => PhotoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails, return sample data for testing
      print('Error fetching photos: $e');
      return _getSamplePhotos();
    }
  }

  // Sample photos for testing when API is not available
  List<PhotoModel> _getSamplePhotos() {
    return List.generate(
      20,
      (index) => PhotoModel(
        id: 'sample_$index',
        url:
            'https://picsum.photos/400/${600 + (index % 3) * 100}?random=$index',
        width: 400,
        height: 600 + (index % 3) * 100,
        description: 'Sample photo $index',
      ),
    );
  }
}

import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/pin_model.dart';

abstract class PinRemoteDataSource {
  Future<List<PinModel>> getCuratedPins({int page = 1, int perPage = 30});
  Future<List<PinModel>> searchPins(String query, {int page = 1, int perPage = 30});
  Future<PinModel> getPinById(String id);
}

class PinRemoteDataSourceImpl implements PinRemoteDataSource {
  final DioClient dioClient;

  PinRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<PinModel>> getCuratedPins({int page = 1, int perPage = 30}) async {
    try {
      // Check if using Pexels or Unsplash
      final usePexels = ApiConstants.pexelsApiKey != 'YOUR_PEXELS_API_KEY';
      
      if (usePexels) {
        // Use Pexels API
        final response = await dioClient.dio.get(
          ApiConstants.curatedPhotos,
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> photos = response.data['photos'] ?? [];
          return photos.map((json) => PinModel.fromPexelsJson(json)).toList();
        } else {
          throw Exception('Failed to load curated photos');
        }
      } else {
        // Use Unsplash API
        final response = await dioClient.dio.get(
          ApiConstants.popularPhotos,
          queryParameters: {
            'page': page,
            'per_page': perPage,
            'order_by': 'popular',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> photos = response.data is List ? response.data : [];
          return photos.map((json) => PinModel.fromUnsplashJson(json)).toList();
        } else {
          throw Exception('Failed to load curated photos');
        }
      }
    } catch (e) {
      print('Error loading pins: $e');
      // Fallback to sample data if API fails
      return _getSamplePins();
    }
  }

  @override
  Future<List<PinModel>> searchPins(String query, {int page = 1, int perPage = 30}) async {
    try {
      // Check if using Pexels or Unsplash
      final usePexels = ApiConstants.pexelsApiKey != 'YOUR_PEXELS_API_KEY';
      
      if (usePexels) {
        // Use Pexels API
        final response = await dioClient.dio.get(
          ApiConstants.searchPhotos,
          queryParameters: {
            'query': query,
            'page': page,
            'per_page': perPage,
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> photos = response.data['photos'] ?? [];
          return photos.map((json) => PinModel.fromPexelsJson(json)).toList();
        } else {
          throw Exception('Failed to search photos');
        }
      } else {
        // Use Unsplash API
        final response = await dioClient.dio.get(
          '/search/photos',
          queryParameters: {
            'query': query,
            'page': page,
            'per_page': perPage,
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> photos = response.data['results'] ?? [];
          return photos.map((json) => PinModel.fromUnsplashJson(json)).toList();
        } else {
          throw Exception('Failed to search photos');
        }
      }
    } catch (e) {
      print('Error searching pins: $e');
      // Fallback to sample data with search query in seed
      return _getSearchSamplePins(query);
    }
  }

  @override
  Future<PinModel> getPinById(String id) async {
    try {
      // Pexels doesn't have a direct get by ID endpoint, so we'll search
      final response = await dioClient.dio.get(
        ApiConstants.searchPhotos,
        queryParameters: {
          'query': id,
          'per_page': 1,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> photos = response.data['photos'] ?? [];
        if (photos.isNotEmpty) {
          return PinModel.fromPexelsJson(photos.first);
        }
      }
      throw Exception('Pin not found');
    } catch (e) {
      // Return sample pin
      return _getSamplePins().first;
    }
  }

  // Sample data fallback - Using Picsum for reliable image URLs
  List<PinModel> _getSamplePins() {
    final heights = [400, 500, 600, 700, 800];
    return List.generate(
      30,
      (index) {
        final height = heights[index % heights.length];
        return PinModel(
          id: 'sample_$index',
          imageUrl: 'https://picsum.photos/seed/pinterest_$index/400/$height',
          width: 400,
          height: height,
          description: 'Beautiful image ${index + 1}',
          photographer: 'Picsum Photos',
          color: '#${(0x1000000 + (index * 0x123456) % 0xFFFFFF).toRadixString(16).substring(1)}',
        );
      },
    );
  }

  // Sample data for search - Using query in seed for variety
  List<PinModel> _getSearchSamplePins(String query) {
    final heights = [400, 500, 600, 700, 800, 900];
    return List.generate(
      20,
      (index) {
        final height = heights[index % heights.length];
        return PinModel(
          id: 'search_${query}_$index',
          imageUrl: 'https://picsum.photos/seed/${query}_$index/400/$height',
          width: 400,
          height: height,
          description: '$query image ${index + 1}',
          photographer: 'Picsum Photos',
          color: '#${(0x1000000 + ((query.hashCode + index) * 0x123456) % 0xFFFFFF).toRadixString(16).substring(1)}',
        );
      },
    );
  }
}

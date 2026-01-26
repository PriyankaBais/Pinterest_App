import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    // Use Pexels API if key is set, otherwise use Unsplash
    final usePexels = ApiConstants.pexelsApiKey != 'YOUR_PEXELS_API_KEY' && 
                       ApiConstants.pexelsApiKey.isNotEmpty;
    
    _dio = Dio(
      BaseOptions(
        baseUrl: usePexels ? ApiConstants.pexelsBaseUrl : ApiConstants.unsplashBaseUrl,
        headers: usePexels
            ? {
                'Authorization': ApiConstants.pexelsApiKey,
              }
            : {
                'Authorization': 'Client-ID ${ApiConstants.unsplashApiKey}',
              },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // LogInterceptor removed to avoid import issues
    // Uncomment if you need request/response logging:
    // _dio.interceptors.add(
    //   LogInterceptor(
    //     requestBody: true,
    //     responseBody: true,
    //     error: true,
    //   ),
    // );
  }

  Dio get dio => _dio;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/pin_remote_datasource.dart';
import '../../data/repositories/pin_repository_impl.dart';
import '../../domain/repositories/pin_repository.dart';
import '../../domain/usecases/get_curated_pins.dart';
import '../../domain/usecases/search_pins.dart';
import '../../domain/usecases/get_pin_by_id.dart';
import '../../domain/entities/pin_entity.dart';

// Dio Client Provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

// Data Source Provider
final pinRemoteDataSourceProvider = Provider<PinRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PinRemoteDataSourceImpl(dioClient);
});

// Repository Provider
final pinRepositoryProvider = Provider<PinRepository>((ref) {
  final remoteDataSource = ref.watch(pinRemoteDataSourceProvider);
  return PinRepositoryImpl(remoteDataSource);
});

// Use Cases Providers
final getCuratedPinsProvider = Provider<GetCuratedPins>((ref) {
  final repository = ref.watch(pinRepositoryProvider);
  return GetCuratedPins(repository);
});

final searchPinsProvider = Provider<SearchPins>((ref) {
  final repository = ref.watch(pinRepositoryProvider);
  return SearchPins(repository);
});

final getPinByIdProvider = Provider<GetPinById>((ref) {
  final repository = ref.watch(pinRepositoryProvider);
  return GetPinById(repository);
});

// State Providers
final curatedPinsProvider = FutureProvider.family<List<PinEntity>, int>((ref, page) async {
  final getCuratedPins = ref.watch(getCuratedPinsProvider);
  return await getCuratedPins.call(page: page, perPage: 30);
});

final searchPinsStateProvider = NotifierProvider<SearchPinsNotifier, SearchPinsState>(() {
  return SearchPinsNotifier();
});

final pinDetailProvider = FutureProvider.family<PinEntity, String>((ref, id) async {
  final getPinById = ref.watch(getPinByIdProvider);
  return await getPinById.call(id);
});

// Search State Notifier
class SearchPinsNotifier extends Notifier<SearchPinsState> {
  @override
  SearchPinsState build() {
    return SearchPinsState.initial();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = SearchPinsState.initial();
      return;
    }

    // Set loading state
    state = state.copyWith(
      isLoading: true,
      pins: [],
      query: query,
      clearError: true,
    );
    
    try {
      final searchPinsUseCase = ref.read(searchPinsProvider);
      final results = await searchPinsUseCase.call(query, page: 1, perPage: 30);
      
      // Set success state
      state = state.copyWith(
        isLoading: false,
        pins: results,
        clearError: true,
      );
    } catch (e) {
      print('Search error: $e');
      // Set error state
      state = state.copyWith(
        isLoading: false,
        pins: [],
        error: e.toString(),
      );
    }
  }

  void clearSearch() {
    state = SearchPinsState.initial();
  }
}

class SearchPinsState {
  final bool isLoading;
  final List<PinEntity> pins;
  final String? error;
  final String query;

  SearchPinsState({
    required this.isLoading,
    required this.pins,
    this.error,
    required this.query,
  });

  factory SearchPinsState.initial() {
    return SearchPinsState(
      isLoading: false,
      pins: [],
      query: '',
    );
  }

  SearchPinsState copyWith({
    bool? isLoading,
    List<PinEntity>? pins,
    String? error,
    String? query,
    bool clearError = false,
  }) {
    return SearchPinsState(
      isLoading: isLoading ?? this.isLoading,
      pins: pins ?? this.pins,
      error: clearError ? null : (error ?? this.error),
      query: query ?? this.query,
    );
  }
}

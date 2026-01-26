import '../entities/pin_entity.dart';

abstract class PinRepository {
  Future<List<PinEntity>> getCuratedPins({int page = 1, int perPage = 30});
  Future<List<PinEntity>> searchPins(String query, {int page = 1, int perPage = 30});
  Future<PinEntity> getPinById(String id);
}

import '../entities/pin_entity.dart';
import '../repositories/pin_repository.dart';

class GetCuratedPins {
  final PinRepository repository;

  GetCuratedPins(this.repository);

  Future<List<PinEntity>> call({int page = 1, int perPage = 30}) async {
    return await repository.getCuratedPins(page: page, perPage: perPage);
  }
}

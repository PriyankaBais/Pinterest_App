import '../entities/pin_entity.dart';
import '../repositories/pin_repository.dart';

class SearchPins {
  final PinRepository repository;

  SearchPins(this.repository);

  Future<List<PinEntity>> call(String query, {int page = 1, int perPage = 30}) async {
    return await repository.searchPins(query, page: page, perPage: perPage);
  }
}

import '../entities/pin_entity.dart';
import '../repositories/pin_repository.dart';

class GetPinById {
  final PinRepository repository;

  GetPinById(this.repository);

  Future<PinEntity> call(String id) async {
    return await repository.getPinById(id);
  }
}

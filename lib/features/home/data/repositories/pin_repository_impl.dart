import '../../domain/entities/pin_entity.dart';
import '../../domain/repositories/pin_repository.dart';
import '../datasources/pin_remote_datasource.dart';
import '../models/pin_model.dart';

class PinRepositoryImpl implements PinRepository {
  final PinRemoteDataSource remoteDataSource;

  PinRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PinEntity>> getCuratedPins({int page = 1, int perPage = 30}) async {
    final List<PinModel> models = await remoteDataSource.getCuratedPins(
      page: page,
      perPage: perPage,
    );
    return models;
  }

  @override
  Future<List<PinEntity>> searchPins(String query, {int page = 1, int perPage = 30}) async {
    final List<PinModel> models = await remoteDataSource.searchPins(
      query,
      page: page,
      perPage: perPage,
    );
    return models;
  }

  @override
  Future<PinEntity> getPinById(String id) async {
    final PinModel model = await remoteDataSource.getPinById(id);
    return model;
  }
}

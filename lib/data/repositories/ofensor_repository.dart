import 'package:catalogo/data/source/github/github_datasource.dart';
import 'package:catalogo/data/source/local/local_datasource.dart';
import 'package:catalogo/data/source/mappers/github_to_local_mapper.dart';
import 'package:catalogo/data/source/mappers/local_to_entity_mapper.dart';
import 'package:catalogo/domain/entities/ofensor.dart';

abstract class OfensorRepository {
  Future<List<Ofensor>> getOfensors({int limit, int page});

  Future<Ofensor> getOfensor(int id);
}

class OfensorDefaultRepository extends OfensorRepository {
  OfensorDefaultRepository({this.githubDataSource, this.localDataSource});

  final GithubDataSource githubDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<Ofensor>> getOfensors({int limit, int page}) async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final OfensorGithubModels = await githubDataSource.getOfensors();
      final OfensorHiveModels = OfensorGithubModels.map((e) => e.toHiveModel());

      await localDataSource.saveOfensors(OfensorHiveModels);
    }

    final OfensorHiveModels = await localDataSource.getOfensors(
      page: page,
      limit: limit,
    );
    final OfensorEntities = OfensorHiveModels
        .where((element) => element != null)
        .map((e) => e.toEntity())
        .toList();

    return OfensorEntities;
  }

  @override
  Future<Ofensor> getOfensor(int id) async {
    final ofensorModel = await localDataSource.getOfensor(id);

    // get all evolutions
    final evolutions = await localDataSource.getEvolucao(ofensorModel);

    final Ofensor = OfensorModel.toEntity();

    return Ofensor;
  }
}

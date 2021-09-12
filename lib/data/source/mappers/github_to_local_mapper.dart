import 'package:catalogo/data/source/github/models/ofensor.dart';
import 'package:catalogo/data/source/local/models/ofensor.dart';

extension GithubOfensorModelToLocalX on GithubOfensorModel {
  OfensorHiveModel toHiveModel() => OfensorHiveModel()
    ..id = (id?.trim() ?? '') as int
    ..name = name?.trim() ?? ''
    ..description = description?.trim() ?? ''
    ..tipo = description?.trim() ?? ''
    ..image = image?.trim() ?? ''
    ..images = images?.toList() ?? []
    ..tempoDuracaoFase = tempoDuracaoFase?.toList() ?? ''
    ..evolucao = evolucao ?? [];
}

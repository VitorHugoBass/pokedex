
import 'package:catalogo/data/source/local/models/ofensor.dart';
import 'package:catalogo/domain/entities/ofensor.dart';

extension OfensorHiveModel on OfensorHiveModel {
  Ofensor toEntity({List<OfensorHiveModel> evolucao = const []}) => Ofensor(
      id: id,
      name: name?.trim() ?? '',
      description: description?.trim() ?? '',
      category: category?.trim() ?? '',
      tipo: tipo.map((e) => OfensorTypesX.parse(e)).toList(),
      image: image?.trim() ?? '',
      images: images?.map((e) => OfensorTypesX.parse(e)).toList(),
      fase: fase?.map((e) => e.toEntity()).toList(),
      tempoDuracaoFase: tempoDuracaoFase?.map((e) => e.toEntity()).toList(),
      evolucao: evolucao?.map((e) => e.toEntity()).toList(),
      color: color?.trim() ?? '');
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ofensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubOfensorModel _$GithubOfensorModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const [
    'id',
    'name',
    'description',
    'category',
    'types',
    'images',
    'image',
    'fase',
    'tempoDuracaoFase',
    'color'
  ]);
  return GithubOfensorModel(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['category'] as String,
      json['tipo'] as String,
      json['image'] as String,
      (json['imagens'] as List)?.map((e) => e as String)?.toList(),
      (json['fase'] as List)?.map((e) => e as String)?.toList(),
      (json['faseduracao'] as List)?.map((e) => e as String)?.toList(),
      (json['evolucao'] as List)?.map((e) => e as String)?.toList()
  );
}

Map<String, dynamic> _$GithubOfensorModelToJson(GithubOfensorModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('id', instance.id);
  val['description'] = instance.description;
  val['category'] = instance.category;
  val['tipo'] = instance.tipo;
  writeNotNull('image', instance.image);
  val['images'] = instance.images;
  val['fase'] = instance.fase;
  val['tempoDuracaoFase'] = instance.tempoDuracaoFase;
  return val;
}

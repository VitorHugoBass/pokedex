import 'package:json_annotation/json_annotation.dart';

part 'ofensor.g.dart';

@JsonSerializable()
class GithubOfensorModel {
  GithubOfensorModel(this.id, this.name, this.description, this.category,
      this.tipo, this.image, this.images, this.fase, this.tempoDuracaoFase, this.evolucao);

  factory GithubOfensorModel.fromJson(Map<String, dynamic> json) =>
      _$GithubOfensorModelFromJson(json);

  Map<String, dynamic> toJson() => _$GithubOfensorModelToJson(this);

  @JsonKey(disallowNullValue: true)
  final String id;

  @JsonKey(disallowNullValue: true)
  final String name;

  @JsonKey(name: 'description', disallowNullValue: true)
  final String description;

  @JsonKey(name: 'category', defaultValue: '')
  final String category;

  @JsonKey(name: 'tipo', defaultValue: '')
  final String tipo;

  @JsonKey(name: 'image', defaultValue: '')
  final String image;

  @JsonKey(name: 'images', disallowNullValue: true)
  final List<String> images;

  @JsonKey(name: 'images', disallowNullValue: true)
  final List<String> fase;

  @JsonKey(name: 'tempoDuracaoFase', disallowNullValue: true)
  final List<String> tempoDuracaoFase;

  @JsonKey(name: 'evolucao', disallowNullValue: true)
  final List<String> evolucao;
}

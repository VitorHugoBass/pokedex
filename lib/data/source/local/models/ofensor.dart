import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:hive/hive.dart';


part 'Ofensor.g.dart';

@HiveType(typeId: 1)
class OfensorHiveModel extends HiveObject {
  static const String boxKey = 'ofensor';

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String tipo;

  @HiveField(4)
  String image;

  @HiveField(5)
  List<String> images;

  @HiveField(6)
  List<String> fase;

  @HiveField(7)
  List<String> tempoDuracaoFase;

  @HiveField(7)
  List<Ofensor> evolucao;

  @HiveField(8)
  String color;

}

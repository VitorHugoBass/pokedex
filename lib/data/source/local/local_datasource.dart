import 'dart:math';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:catalogo/data/source/local/models/ofensor.dart';

class LocalDataSource {
  static void initialize() async {
    await Hive.initFlutter();


    await Hive.openBox<OfensorHiveModel>(OfensorHiveModel.boxKey);
  }

  Future<bool> hasData() async {
    final OfensorBox = Hive.box<OfensorHiveModel>(OfensorHiveModel.boxKey);

    return OfensorBox.length > 0;
  }

  Future<void> saveOfensors(Iterable<OfensorHiveModel> Ofensors) async {
    final OfensorBox = Hive.box<OfensorHiveModel>(OfensorHiveModel.boxKey);

    final OfensorsMap = {for (var e in Ofensors) e.id: e};

    await OfensorBox.clear();
    await OfensorBox.putAll(OfensorsMap);
  }

  Future<List<OfensorHiveModel>> getOfensors({int page, int limit}) async {
    final OfensorBox = Hive.box<OfensorHiveModel>(OfensorHiveModel.boxKey);
    final totalOfensors = OfensorBox.length;

    final start = (page - 1) * limit;
    final newOfensorCount = min(totalOfensors - start, limit);

    final Ofensors = List.generate(
        newOfensorCount, (index) => OfensorBox.getAt(start + index));

    return Ofensors;
  }

  Future<OfensorHiveModel> getOfensor(int id) async {
    final ofensorBox = Hive.box<OfensorHiveModel>(OfensorHiveModel.boxKey);

    return ofensorBox.get(id);
  }

  Future<List<OfensorHiveModel>> getEvolucao(OfensorHiveModel ofensor) async {
    final ofensorFutures =
      ofensor.evolucao.map((ofensorId) => getOfensor(ofensor.id));

    final ofensorResp = await Future.wait(ofensorFutures);

    return ofensorResp;
  }
}

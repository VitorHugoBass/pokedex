import 'package:flutter/material.dart';

import '../../core/usecase.dart';
import '../../data/repositories/Ofensor_repository.dart';
import '../entities/ofensor.dart';

class GetOfensorsParams {
  const GetOfensorsParams({
    @required this.page,
    @required this.limit,
  });

  final int page;
  final int limit;
}

class GetOfensorsUseCase extends UseCase<List<Ofensor>, GetOfensorsParams> {
  const GetOfensorsUseCase(this.repository);

  final OfensorRepository repository;

  @override
  Future<List<Ofensor>> call(GetOfensorsParams params) {
    return repository.getOfensors(page: params.page, limit: params.limit);
  }
}

class GetOfensorParam {
  final int id;

  const GetOfensorParam(this.id);
}

class GetOfensorUseCase extends UseCase<Ofensor, GetOfensorParam> {
  final OfensorRepository repository;

  const GetOfensorUseCase(this.repository);

  @override
  Future<Ofensor> call(GetOfensorParam params) {
    return repository.getOfensor(params.id);
  }
}

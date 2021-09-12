part of 'providers.dart';

final getOfensorUseCaseProvider = Provider<GetOfensorUseCase>((ref) {
  final OfensorRepository = ref.watch(OfensorRepositoryProvider);

  return GetOfensorUseCase(OfensorRepository);
});

final getOfensorsUseCaseProvider = Provider<GetOfensorsUseCase>((ref) {
  final OfensorRepository = ref.watch(OfensorRepositoryProvider);

  return GetOfensorsUseCase(OfensorRepository);
});

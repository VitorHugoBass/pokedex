part of 'providers.dart';

final currentOfensorStateProvider = ChangeNotifierProvider<CurrentOfensorState>((ref) {
  final getOfensorUseCase = ref.watch(getOfensorUseCaseProvider);

  return CurrentOfensorState(getOfensorUseCase);
});

final ofensorsStateProvider = ChangeNotifierProvider<OfensorListState>((ref) {
  final getOfensorsUseCase = ref.watch(getOfensorsUseCaseProvider);

  return ofensorListState(getOfensorsUseCase);
});

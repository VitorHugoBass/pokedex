part of 'providers.dart';

final OfensorRepositoryProvider = Provider<OfensorRepository>((ref) {
  final githubDataSource = ref.watch(githubSourceProvider);
  final localDataSource = ref.watch(localSourceProvider);

  return OfensorDefaultRepository(
    githubDataSource: githubDataSource,
    localDataSource: localDataSource,
  );
});

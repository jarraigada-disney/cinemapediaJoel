import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieController extends AutoDisposeAsyncNotifier<List<Movie>> {
  late MoviesRepository repository;
  var currentPage = 1;
  bool isLoadingMore = false;
  @override
  Future<List<Movie>> build() {
    repository = ref.watch(movieRepositoryProvider);
    return _initData();
  }

  Future<List<Movie>> _initData() async {
    return await fetchMoreMovies(currentPage);
  }

  Future<List<Movie>> fetchMoreMovies(int page) {
    return repository.getNowPlaying(page: page);
  }

  final movieListProvider = StateProvider<List<Movie>>((ref) {
    return [];
  });

  Future<void> loadNextPage() async {
    if(isLoadingMore) return;
    isLoadingMore=true;

    try {
      state = AsyncValue.loading();

      currentPage++;

      final existingMovies = ref.read( movieListProvider);

      final List<Movie> newMovies =
          await fetchMoreMovies(currentPage); // Fetch new movies

      state = AsyncValue.data([...existingMovies, ...newMovies]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final movieControllerProvider =
    AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController();
});

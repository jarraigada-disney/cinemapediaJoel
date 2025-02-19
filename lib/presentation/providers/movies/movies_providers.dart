import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieController extends AsyncNotifier<List<Movie>> {

  late MoviesRepository repository;
  var currentPage = 0;
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

  Future<void> loadNextPage() async {
    currentPage++;
    try {
      state = AsyncValue.loading();
      final List<Movie> movies = await fetchMoreMovies(currentPage);
      state = AsyncValue.data(movies);
    } catch (e, stackTrace) {
      AsyncValue.error(e, stackTrace);
    }
  }
}

final movieControllerProvider =
    AsyncNotifierProvider<MovieController, List<Movie>>(() {
  return MovieController();
});

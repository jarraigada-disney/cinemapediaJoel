import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final fetchMoviesProvider = Provider.family<FetchMoviesProvider,MovieType>((ref,movieType) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return FetchMoviesProvider(
    movieRepository: movieRepository,
  );
});


class MovieController extends AutoDisposeAsyncNotifier<List<Movie>> {
  var currentPage = 1;
  bool isLoadingMore = false;
  final MovieType movieType;

  MovieController({required this.movieType});

  @override
  Future<List<Movie>> build() {
    final fetchMovies = ref.watch(fetchMoviesProvider(movieType));
    return fetchMovies.fetchMovies(movieType, page: currentPage);
  }

  Future<void> loadNextPage() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    print('loading more');
    currentPage++;

    final fetchMovies = ref.watch(fetchMoviesProvider(movieType));
    final newMovies = await fetchMovies.fetchMovies(movieType, page: currentPage);

    state = AsyncValue.data([...state.value!, ...newMovies]);
    await Future.delayed(const Duration(milliseconds: 200));
    isLoadingMore = false;
  }
}





final nowPlayingMoviesProvider = AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(movieType: MovieType.nowPlaying);
});

final popularMoviesProvider = AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(movieType: MovieType.popular);
});

final topRatedMoviesProvider = AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(movieType: MovieType.topRated);
});

final upcomingMoviesProvider = AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(movieType: MovieType.upcoming);
});


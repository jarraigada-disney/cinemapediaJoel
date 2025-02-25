import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieFetchFunction = Future<List<Movie>> Function(MoviesRepository repository, int page);

Future<List<Movie>> fetchNowPlayingMovies(MoviesRepository repository, int page) {
  return repository.getNowPlaying(page: page);
}

Future<List<Movie>> fetchPopularMovies(MoviesRepository repository, int page) {
  return repository.getPopular(page: page);
}

Future<List<Movie>> fetchTopRatedMovies(MoviesRepository repository, int page) {
  return repository.getTopRated(page: page);
}

Future<List<Movie>> fetchUpcomingMovies(MoviesRepository repository, int page) {
  return repository.getUpcoming(page: page);
}

class MovieController extends AutoDisposeAsyncNotifier<List<Movie>> {
  var currentPage = 1;
  bool isLoadingMore = false;
  late MovieFetchFunction fetchMovies;

  MovieController(this.fetchMovies);

  @override
  Future<List<Movie>> build() {
    final repository = ref.watch(movieRepositoryProvider);
    return _initData(repository);
  }

  Future<List<Movie>> _initData(MoviesRepository repository) async {
    return await fetchMovies(repository,currentPage);
  }

  Future<void> loadNextPage() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    print('loading more');
    currentPage++;
    final repository = ref.watch(movieRepositoryProvider);
    final newMovies = await fetchMovies(repository,currentPage);
    state = AsyncValue.data([...state.value!, ...newMovies]);
    await Future.delayed(const Duration(milliseconds: 200));
    isLoadingMore = false;
  }

}

final nowPlayingMoviesProvider = 
  
  AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
    
  return MovieController(fetchNowPlayingMovies);
});

final popularMoviesProvider = 
  AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(fetchPopularMovies);
});


final topRatedMoviesProvider =
  AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(fetchTopRatedMovies);
});

final UpcomingMoviesProvider =
  AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
  return MovieController(fetchUpcomingMovies);
});







// class MovieController extends AutoDisposeAsyncNotifier<List<Movie>> {
//   late MoviesRepository repository;
//   var currentPage = 1;
//   bool isLoadingMore = false;
//   @override
//   Future<List<Movie>> build() {
//     repository = ref.watch(movieRepositoryProvider);
//     return _initData();
//   }

//   Future<List<Movie>> _initData() async {
//     return await fetchMoreMovies(currentPage);
//   }

//   Future<List<Movie>> fetchMoreMovies(int page) {
//     return repository.getNowPlaying(page: page);
//   }

//   Future<void> loadNextPage() async {
//     if (isLoadingMore) return;

//     isLoadingMore = true;
//     print('loading moreeeee');
//     currentPage++;
//     final newMovies = await fetchMoreMovies(currentPage);
//     state = AsyncValue.data([...state.value!, ...newMovies]);
//     await Future.delayed(const Duration(milliseconds: 200));
//     isLoadingMore = false;
//   }
// }

// final movieControllerProvider =
//     AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
//   return MovieController();
// });

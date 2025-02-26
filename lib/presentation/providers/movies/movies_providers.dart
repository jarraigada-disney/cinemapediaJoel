import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FetchMoviesProvider {
  final MoviesRepository movieRepository;
  // final Movies2Repository movie2Repository;

  FetchMoviesProvider({
    required this.movieRepository,
    // required this.movie2Repository,
  });

  Future<List<Movie>> fetchMovies(MovieType movieType, {required int page}) {
    switch (movieType) {
      case MovieType.nowPlaying:
        return movieRepository.getNowPlaying(page: page);
      case MovieType.popular:
        return movieRepository.getPopular(page: page);
      case MovieType.topRated:
        return movieRepository.getTopRated(page: page);
      case MovieType.upcoming:
        return movieRepository.getUpcoming(page: page);
    }
  }
}

enum MovieType {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}


final fetchMoviesProvider = Provider<FetchMoviesProvider>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  // final movie2Repository = ref.watch(movie2RepositoryProvider);

  return FetchMoviesProvider(
    movieRepository: movieRepository,
    // movie2Repository: movie2Repository,
  );
});

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
  final MovieType movieType;

  MovieController({required this.movieType});

  @override
  Future<List<Movie>> build() {
    final fetchMovies = ref.watch(fetchMoviesProvider);
    return fetchMovies.fetchMovies(movieType, page: currentPage);
  }

  Future<void> loadNextPage() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    print('loading more');
    currentPage++;

    final fetchMovies = ref.watch(fetchMoviesProvider);
    final newMovies = await fetchMovies.fetchMovies(movieType, page: currentPage);

    state = AsyncValue.data([...state.value!, ...newMovies]);
    await Future.delayed(const Duration(milliseconds: 200));
    isLoadingMore = false;
  }
}

// class MovieController extends AutoDisposeAsyncNotifier<List<Movie>> {
//   var currentPage = 1;
//   bool isLoadingMore = false;
//   late MovieFetchFunction fetchMovies;
//   final MovieType movieType;

//   MovieController({required this.movieType});

//   @override
//   Future<List<Movie>> build() {
//     return _initData();
//   }

//   Future<List<Movie>> _initData(MoviesRepository repository) async {
//     return await fetchMovies(repository,currentPage);
//   }

//   Future<void> loadNextPage() async {
//     if (isLoadingMore) return;

//     isLoadingMore = true;
//     print('loading more');
//     currentPage++;
//     final repository = ref.watch(movieRepositoryProvider);
//     final newMovies = await fetchMovies(repository,currentPage);
//     state = AsyncValue.data([...state.value!, ...newMovies]);
//     await Future.delayed(const Duration(milliseconds: 200));
//     isLoadingMore = false;
//   }

// }


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
// final nowPlayingMoviesProvider = 
//   AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
//   return MovieController(fetchNowPlayingMovies);
// });

// final popularMoviesProvider = 
//   AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
//   return MovieController(fetchPopularMovies);
// });


// final topRatedMoviesProvider =
//   AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
//   return MovieController(fetchTopRatedMovies);
// });

// final UpcomingMoviesProvider =
//   AsyncNotifierProvider.autoDispose<MovieController, List<Movie>>(() {
//   return MovieController(fetchUpcomingMovies);
// });






import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final fetchMoviesProvider = Provider<FetchMoviesProvider>((ref) {
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








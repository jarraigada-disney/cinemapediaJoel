import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/movies_repository.dart';

class FetchMoviesProvider {
  final MoviesRepository movieRepository;

  FetchMoviesProvider({
    required this.movieRepository,
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

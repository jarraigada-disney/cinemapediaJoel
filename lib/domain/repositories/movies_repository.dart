import '../entities/movie.dart';


//The repository call the Data Source 


abstract class MoviesRepository {

  Future <List<Movie>> getNowPlaying({int page = 1});

  Future <List<Movie>> getPopular({int page = 1});

  Future <List<Movie>> getTopRated({int page = 1});

  Future <List<Movie>> getUpcoming({int page = 1});

  Future <List<Movie>> searchMovies(String query);

  Future<Movie> getMovieById(String id);
}
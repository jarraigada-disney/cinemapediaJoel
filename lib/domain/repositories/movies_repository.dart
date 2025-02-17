import '../entities/movie.dart';


//The repository call the Data Source 


abstract class MoviesRepository {

  Future <List<Movie>> getNowPlaying({int page = 1});

}
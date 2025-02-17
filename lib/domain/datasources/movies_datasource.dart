import '../entities/movie.dart';


//DATA ORIGIN


abstract class MoviesDatasource {

  Future <List<Movie>> getNowPlaying({int page = 1});

}
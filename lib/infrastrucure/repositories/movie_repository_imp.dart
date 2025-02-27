import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImp extends MoviesRepository {
  //llamo la clase padre, llamado generico que sirve para cualquier datasource no solo moviedbdatasource
  final MoviesDatasource datasource;
  MovieRepositoryImp(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return this.datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return this.datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return this.datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return this.datasource.getUpcoming(page: page);
}

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}

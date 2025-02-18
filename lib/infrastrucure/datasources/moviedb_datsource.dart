import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastrucure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastrucure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';


//Implementacion en especifico de mi fuente de informacion actual (The Movie DB)
class MoviedbDatsource extends MoviesDatasource{

  final dio = Dio(BaseOptions(
    baseUrl:'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'en-US'
    } 
    ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
  
    final response = await dio.get('/movie/now_playing');

    final movieDbResponse = MovieDbResponse.fromJson(response.data); // Recibo el Json

    //Mapeo el resultado y devuelvo un list de movies
    final List<Movie> movies = movieDbResponse.results
    .where((moviedb)=> moviedb.posterPath!='no-poster')//Filtro el hecho de que el poster path puede devolver 'no-poster' (a modo de ejemplo de FH)
    .map( 
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;

  }

  
}
// Read a model and create a Movie entity. In this case it reads a MovieDB and creates  a Movie

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastrucure/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult, 
      backdropPath: moviedb.backdropPath!=''?
      'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      :'https://www.content.numetro.co.za/ui_images/no_poster.png',
      genreIds: moviedb.genreIds.map((e)=>e.toString()).toList(),
      id: moviedb.id, 
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath!=''?
      'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
      :'no-poster',
      releaseDate: moviedb.releaseDate,
      title:moviedb. title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
      );
}
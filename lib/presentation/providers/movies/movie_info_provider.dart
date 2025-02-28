
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref){

  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepository.getMovieById);

});

typedef GetMovieCallback = Future<Movie>Function(String movieID);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
    }):super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId]!=null) return; // si ya esta cargado no la llamo de nuevo
    final movie = await getMovie(movieId);
    print('peticcion http');
    state = {...state, movieId: movie};
  }

}
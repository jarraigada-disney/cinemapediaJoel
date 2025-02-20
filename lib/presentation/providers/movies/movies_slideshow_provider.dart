import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

//innecesario, solo para limitar desde aca la cantidad de peliculas

final movieSlideshowProvider = Provider.autoDispose<List<Movie>>((ref) {
  final movieState = ref.watch(movieControllerProvider);
  return movieState.when(
    data: (movies){
      return movies.isEmpty? []:movies.sublist(12,19);
    },
    error: (error, stackTrace)=> [],
    loading: ()=>[]);
});

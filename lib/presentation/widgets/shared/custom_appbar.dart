import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class CustomAppbar extends ConsumerWidget{

  const CustomAppbar({super.key});
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined,color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia',style: titleStyle,),
              const Spacer(),
              IconButton(
                onPressed: ()  {

                  final movieRepository = ref.read(movieRepositoryProvider);

                  final movie = showSearch<Movie?>(
                    context: context, //Change await, bad practice!!
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies //Solo la referencia a la funcion
                  )
                  ).then((movie){
                    if(movie==null) return;

                    context.push('/movie/${movie.id}');
                  });
              
                  
                },
                 icon: const Icon(Icons.search))
            ],
          ),
        ),
        ));
  }
}
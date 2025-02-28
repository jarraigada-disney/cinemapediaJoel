// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  SearchMovieDelegate({
    required this.searchMovies,
  });

  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty)
      return [
        FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: Icon(Icons.clear_rounded)))
      ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Optionall
    return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      initialData: [],
      builder: (context,snapshot){

        final movies = snapshot.data ??[]; // para tipado estricto(?)


        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context,index){
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: close);
          });
      });
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  const _MovieItem({required this.movie, required this.onMovieSelected});
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap:() {
        onMovieSelected(context,movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          children: [
      
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder:(context, child, loadingProgress) => FadeIn(child: child),),
              ),
            ),
          const SizedBox(width: 10,),
      
      
      
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,style: textStyles.titleLarge,),
                (movie.overview.length>100)
                ? Text('${movie.overview.substring(0,100)}...')
                : Text(movie.overview),
      
      
                Row(
                  children: [
                     Icon(Icons.star_half_outlined,color: Colors.amber, ),
                     const SizedBox(width: 5,),
                     Text(
                       HumanFormats.number(movie.voteAverage,1),
                      style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),)
                  ],
                )
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
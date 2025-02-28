import 'package:cinemapedia/infrastrucure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key,
  required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);



  }


  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId]; //obtengo la pelicula del Mapa con el id como clave

    if(movie == null){
      return Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 2,)),
      );
    }

    return  Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index)=> _MovieDetails(movie: movie),
            childCount: 1
            ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width*0.3,

                ),
              ),
              const SizedBox(width: 10,),


              //description
              SizedBox(width: (size.width-40)*0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  movie.title,
                  style: textStyle.titleLarge,),
                  Text(
                  movie.overview,
                  style: textStyle.bodyLarge,),
                ],
              ),)
            ],
          ),
        ),
        //Genres
        Padding(padding: const EdgeInsets.all(8),
        child: Wrap(
          children: [
            ...movie.genreIds.map((genre)=>Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(genre),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
            ))
          ],
        ),),
        //Actors
        const SizedBox(height: 100,)
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {


  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(color:Colors.white, fontSize: 20),
        //   textAlign: TextAlign.center,
        //   ),
      background: Stack(
        children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover
              ),
          ),
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7,1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black87
                  ])
              )),
          )
        ],
      ),
      ),
    );
  }
}
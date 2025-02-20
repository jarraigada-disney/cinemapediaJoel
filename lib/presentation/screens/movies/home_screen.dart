import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _HomeView(),
    ));
  }
}

class _HomeView extends ConsumerWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlayingMovies = ref.watch(movieControllerProvider);
    //final slideShowMovies = ref.watch(movieSlideshowProvider); 
    return nowPlayingMovies.when(
      data: (data) => _movieList(nowPlayingMovies: data.sublist(12,19)),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      loading: () => CircularProgressIndicator(),
    );
  }
}

class _movieList extends StatelessWidget {
  const _movieList({super.key, required this.nowPlayingMovies});

  final List<Movie> nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideshow(movies: nowPlayingMovies),
      ],
    );
  }
}

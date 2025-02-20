// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class _HomeView extends ConsumerWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlayingMovies = ref.watch(movieControllerProvider);
    return Column(children: [
      CustomAppbar(),
      nowPlayingMovies.when(
        data: (data) => _HomeBodyView(movies: data),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      )
    ]);
  }
}

class _HomeBodyView extends StatelessWidget {
  final List<Movie> movies;
  const _HomeBodyView({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoviesSlideshow( movies: movies.sublist(12, 19)),
        MovieHorizontalListview(
          movies: movies,
          title: 'En cines',
          subtitle: 'Hoy',
          loadNextPage: () {print('Llamado del padre');},),
         ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinemapedia/presentation/providers/providers.dart';
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

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //it Returns the current State of the provider
    
    
    final popularMovies = ref.watch(popularMoviesProvider);
    final popularMoviesNotifier = ref.watch(popularMoviesProvider.notifier); //The notifier itself


    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final topRatedMoviesNotifier = ref.watch(topRatedMoviesProvider.notifier);

    final upcomingMovies = ref.watch(UpcomingMoviesProvider);
    final upcomingMoviesNotifier = ref.watch(UpcomingMoviesProvider.notifier);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            nowPlayingMovies.when(
              data: (data) => _HomeBodyView(
                movies: data,
                ref: ref,
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            popularMovies.when(
              data: (data) => MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Popular Movies',
                  subtitle: 'Now',
                  loadNextPage: () {
                    return popularMoviesNotifier.loadNextPage();
                  }),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            topRatedMovies.when(
              data: (data) => MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Top Rated',
                  subtitle: 'All time',
                  loadNextPage: () {
                    return topRatedMoviesNotifier.loadNextPage();
                  }),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            upcomingMovies.when(
              data: (data) => MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Upcoming',
                  // subtitle: 'All time',
                  loadNextPage: () {
                    return upcomingMoviesNotifier.loadNextPage();
                  }),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            )
          ]);
        }, childCount: 1))
      ],
    );
  }
}

class _HomeBodyView extends ConsumerWidget {
  final List<Movie> movies;
  final WidgetRef ref;
  const _HomeBodyView({required this.movies, required this.ref});

  @override
  Widget build(BuildContext context, ref) {
    final movieController = ref.watch(
        nowPlayingMoviesProvider.notifier); //It returns the notifier itself

    return Column(
      children: [
        MoviesSlideshow(movies: movies.sublist(0, 7)),
        MovieHorizontalListview(
          initialMovies: movies,
          title: 'In Theaters',
          subtitle: 'Today',
          loadNextPage: () {
            return movieController.loadNextPage();
          },
        ),
      ],
    );
  }
}

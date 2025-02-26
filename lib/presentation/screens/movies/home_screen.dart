import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          return Column(
            children: [
            NowPlayingMoviesScrollAndSlide(),
            PopularMoviesScroll(),
            TopRatedMoviesScroll(),
            UpcomingMoviesScroll()
          ]);
        }, childCount: 1))
      ],
    );
  }
  }

  class PopularMoviesScroll extends ConsumerWidget{
    const PopularMoviesScroll({super.key});
    @override
    Widget build (BuildContext context, WidgetRef ref){
    final popularMovies = ref.watch(popularMoviesProvider);
    final popularMoviesNotifier = ref.watch(popularMoviesProvider.notifier);
    return  popularMovies.when(
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
            );
  }
}

 class UpcomingMoviesScroll extends ConsumerWidget{
    const UpcomingMoviesScroll({super.key});
    @override
    Widget build (BuildContext context, WidgetRef ref){
   final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final upcomingMoviesNotifier = ref.watch(upcomingMoviesProvider.notifier);
    return  upcomingMovies.when(
              data: (data) => MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Upcoming',
                  // subtitle: 'Now',
                  loadNextPage: () {
                    return upcomingMoviesNotifier.loadNextPage();
                  }),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            );
  }
}

class TopRatedMoviesScroll extends ConsumerWidget{
    const TopRatedMoviesScroll({super.key});
    @override
    Widget build (BuildContext context, WidgetRef ref){
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final topRatedMoviesNotifier = ref.watch(topRatedMoviesProvider.notifier);
    return  topRatedMovies.when(
              data: (data) => MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Top Rated ',
                  subtitle: 'All time',
                  loadNextPage: () {
                    return topRatedMoviesNotifier.loadNextPage();
                  }),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            );
  }
}

class NowPlayingMoviesScrollAndSlide extends ConsumerWidget{
    const NowPlayingMoviesScrollAndSlide({super.key});
    @override
    Widget build (BuildContext context, WidgetRef ref){
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlayingMoviesNotifier = ref.watch(nowPlayingMoviesProvider.notifier);
    return  nowPlayingMovies.when(
              data: (data) => 
              Column(
      children: [
        MoviesSlideshow(movies: data.sublist(0, 7)),
        MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Top Rated ',
                  subtitle: 'All time',
                  loadNextPage: () {
                    return nowPlayingMoviesNotifier.loadNextPage();
                  })
      ],
    ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            );
  }
}

// class _HomeBodyView extends ConsumerWidget {
//   final List<Movie> movies;
//   final WidgetRef ref;
//   const _HomeBodyView({required this.movies, required this.ref});

//   @override
//   Widget build(BuildContext context, ref) {
//     final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
//     final nowPlayingMoviesNotifier = ref.watch(nowPlayingMoviesProvider.notifier);

//     return Column(
//       children: [
//         MoviesSlideshow(movies: movies.sublist(0, 7)),
//         MovieHorizontalListview(
//                   initialMovies: movies,
//                   title: 'Top Rated ',
//                   subtitle: 'All time',
//                   loadNextPage: () {
//                     return nowPlayingMoviesNotifier.loadNextPage();
//                   })
//       ],
//     );
//   }
// }
  
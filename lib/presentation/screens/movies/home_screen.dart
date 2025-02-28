import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    

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
            NowPlayingMoviesScrollAndSlide(nowPlayingMovies),
            TopRatedMoviesScroll(upcomingMovies),
            PopularMoviesScroll(popularMovies),
            UpcomingMoviesScroll(topRatedMovies)
          ]);
        }, childCount: 1))
      ],
    );
  }
  }

  class PopularMoviesScroll extends ConsumerWidget{
  final AsyncValue<List<Movie>> popularMovies;
  
    const PopularMoviesScroll(this.popularMovies,{super.key});

    
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
    final AsyncValue<List<Movie>> upcomingMovies;
  
    const UpcomingMoviesScroll(this.upcomingMovies,{super.key});
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
    final AsyncValue<List<Movie>> topRatedMovies;
  
    const TopRatedMoviesScroll(this.topRatedMovies,{super.key});
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
    const NowPlayingMoviesScrollAndSlide(this.nowPlayingMovies , {super.key});

    final AsyncValue<List<Movie>> nowPlayingMovies;
    @override
    Widget build (BuildContext context, WidgetRef ref){
    final nowPlayingMoviesNotifier = ref.watch(nowPlayingMoviesProvider.notifier);
    return  nowPlayingMovies.when(
              data: (data) => 
              Column(
      children: [
        MoviesSlideshow(movies: data.sublist(15,20)),
        MovieHorizontalListview(
                  initialMovies: data,
                  title: 'Now playing ',
                  subtitle: 'Today',
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
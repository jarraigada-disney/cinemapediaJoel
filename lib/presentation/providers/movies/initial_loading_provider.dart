import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref){


    final step1 = ref.watch(nowPlayingMoviesProvider);
    final step2 = ref.watch(popularMoviesProvider);
    final step3 = ref.watch(upcomingMoviesProvider);
    final step4 = ref.watch(topRatedMoviesProvider);


    if(step1.isLoading || step2.isLoading || step3.isLoading || step4.isLoading) return true;

    return false;
});
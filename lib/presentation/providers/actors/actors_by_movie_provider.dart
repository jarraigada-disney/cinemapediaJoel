
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';


final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,Map<String,List<Actor>>>((ref){

  final actorsRepository = ref.watch(actorRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie );

});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieID);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>>{

  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
    }):super({}); 

  Future<void> loadActors(String movieId) async{
    if(state[movieId]!=null) return; // si ya esta cargado no la llamo de nuevo


    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }

}
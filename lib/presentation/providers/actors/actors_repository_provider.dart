import 'package:cinemapedia/infrastrucure/datasources/actors_moviedb_datasource.dart';
import 'package:cinemapedia/infrastrucure/repositories/acotr_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref){



return AcotrRepositoryImp(ActorMoviedbDatasource());

}



);
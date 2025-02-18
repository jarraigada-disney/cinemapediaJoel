import 'package:cinemapedia/infrastrucure/datasources/moviedb_datsource.dart';
import 'package:cinemapedia/infrastrucure/repositories/movie_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Repositorio de solo lectura inmutable, por eso uso Provider()

final movieRepositoryProvider = Provider((ref){



return MovieRepositoryImp(MoviedbDatsource());

}



);
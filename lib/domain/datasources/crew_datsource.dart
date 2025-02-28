import 'package:cinemapedia/domain/entities/crew.dart';

abstract class CrewDatasource {

  Future<List<Crew>> getCastByMovie(String movieId);
}
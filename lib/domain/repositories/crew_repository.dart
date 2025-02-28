import '../entities/crew.dart';

abstract class CastRepository {

  Future<List<Crew>> getCastByMovie(String movieId);
}
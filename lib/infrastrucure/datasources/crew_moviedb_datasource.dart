import 'package:cinemapedia/domain/datasources/crew_datsource.dart';
import 'package:cinemapedia/domain/entities/crew.dart';
import 'package:cinemapedia/infrastrucure/mappers/crew_mapper.dart';
import 'package:cinemapedia/infrastrucure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../mappers/movie_mapper.dart';

class CrewMoviedbDatasource extends CrewDatasource{


  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'en-US'
      })
      );
  @override
  Future<List<Crew>> getCastByMovie(String movieId) async{


    // final response = await dio.get('/movie/$movieId/credits');
    // if(response.statusCode !=200) throw Exception('Movie with id: $movieId not found');

    // final crewResponse = CreditsResponse.fromJson(response.data);
    // List<Crew> crew = crewResponse.cast.map(
    //   // (crew)=>CrewMapper.castToEntity(crecw as Crew)
    // ).toList();


    return[];
  }
}
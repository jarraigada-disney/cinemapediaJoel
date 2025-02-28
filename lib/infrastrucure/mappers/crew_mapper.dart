import 'package:cinemapedia/domain/entities/crew.dart';

class CrewMapper{
  static Crew castToEntity (Crew cast)=> Crew(
    id: cast.id, 
    name: cast.name,
    profilePath: cast.profilePath!=null
  ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
  : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7FFnwgGnpnI9RDP35VyvHXM_ZKFHSfztBGw&s',
    character: cast.character);
}
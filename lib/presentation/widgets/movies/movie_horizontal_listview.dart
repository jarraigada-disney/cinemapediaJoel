import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Title(
              title: title,
              subitle: subtitle,
            ),
          Expanded(
              child: ListView.builder(
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _Slide(movie: movies[index]);
                  }))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null)
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              const CircularProgressIndicator(strokeWidth: 2)),
                    );
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(),
          //Title
          SizedBox(
              width: 150,
              child:
                  Text(movie.title, maxLines: 2, style: textStyles.titleSmall)),
          //Rating
          Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.amber,
              ),
              const SizedBox(width: 3),
              Text('${movie.voteAverage}',
                  style: textStyles.bodyMedium?.copyWith(color: Colors.amber)),
              const SizedBox(width: 10),
              Text('${movie.popularity}',style:textStyles.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subitle;

  const _Title({this.title, this.subitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          Spacer(),
          if (subitle != null)
            FilledButton.tonal(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subitle!))
        ],
      ),
    );
  }
}

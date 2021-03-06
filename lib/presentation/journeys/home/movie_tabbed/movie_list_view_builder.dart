import 'package:flutter/material.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/domain/entities/movie_entity.dart';
import 'package:moviemix/common/extension/size_extension.dart';
import 'movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  //1
  final List<MovieEntity> movies;

  const MovieListViewBuilder({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
            movieId: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
          );
        },
      ),
    );
  }
}

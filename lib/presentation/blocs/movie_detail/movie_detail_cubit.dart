import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_detail_entity.dart';
import 'package:moviemix/domain/entities/movie_params.dart';
import 'package:moviemix/domain/use_case/get_movie_detail.dart';
import 'package:moviemix/presentation/blocs/cast/cast_cubit.dart';
import 'package:moviemix/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:moviemix/presentation/blocs/loading/loading_cubit.dart';
import 'package:moviemix/presentation/blocs/videos/videos_cubit.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastCubit castCubit;
  final VideosCubit videosCubit;
  final FavoriteCubit favoriteCubit;
  final LoadingCubit loadingCubit;

  MovieDetailCubit({
    @required this.getMovieDetail,
    @required this.castCubit,
    @required this.videosCubit,
    @required this.favoriteCubit,
    @required this.loadingCubit,
  }) : super(MovieDetailInitial());

  void loadMovieDetail(int movieId) async {
    loadingCubit.show();
    final Either<AppError, MovieDetailEntity> eitherResponse =
        await getMovieDetail(
      MovieParams(movieId),
    );
    emit(eitherResponse.fold(
      (l) => MovieDetailError(),
      (r) => MovieDetailLoaded(r),
    ));

    favoriteCubit.checkIfMovieFavorite(movieId);
    castCubit.loadCast(movieId);
    videosCubit.loadVideos(movieId);
    loadingCubit.hide();
  }
}

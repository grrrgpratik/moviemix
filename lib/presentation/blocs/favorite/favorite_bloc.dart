import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_entity.dart';
import 'package:moviemix/domain/entities/movie_params.dart';
import 'package:moviemix/domain/entities/no_params.dart';
import 'package:moviemix/domain/use_case/check_if_favorite_movie.dart';
import 'package:moviemix/domain/use_case/delete_favorite_movie.dart';
import 'package:moviemix/domain/use_case/get_favorite_movies.dart';
import 'package:moviemix/domain/use_case/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;

  FavoriteBloc({
    @required this.saveMovie,
    @required this.getFavoriteMovies,
    @required this.deleteFavoriteMovie,
    @required this.checkIfFavoriteMovie,
  }) : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveMovie(event.movieEntity);
      }
      final response =
          await checkIfFavoriteMovie(MovieParams(event.movieEntity.id));
      yield response.fold(
        (l) => FavoriteMoviesError(),
        (r) => IsFavoriteMovie(r),
      );
    } else if (event is LoadFavoriteMovieEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavoriteMovie(MovieParams(event.movieId));
      yield* _fetchLoadFavoriteMovies();
    } else if (event is CheckIfFavoriteMovieEvent) {
      final response = await checkIfFavoriteMovie(MovieParams(event.movieId));
      yield response.fold(
        (l) => FavoriteMoviesError(),
        (r) => IsFavoriteMovie(r),
      );
    }
  }

  Stream<FavoriteState> _fetchLoadFavoriteMovies() async* {
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovies(NoParams());

    yield response.fold(
      (l) => FavoriteMoviesError(),
      (r) => FavoriteMoviesLoaded(r),
    );
  }
}

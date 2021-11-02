import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_entity.dart';
import 'package:moviemix/domain/entities/movie_search_params.dart';
import 'package:moviemix/domain/use_case/search_movies.dart';
import 'package:moviemix/presentation/blocs/loading/loading_bloc.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  final LoadingBloc loadingBloc;

  SearchMovieBloc({
    @required this.searchMovies,
    @required this.loadingBloc,
  }) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    loadingBloc.add(StartLoading());
    if (event is SearchTermChangedEvent) {
      if (event.searchTerm.length > 2) {
        yield SearchMovieLoading();
        final Either<AppError, List<MovieEntity>> response =
            await searchMovies(MovieSearchParams(searchTerm: event.searchTerm));
        yield response.fold(
          (l) => SearchMovieError(l.appErrorType),
          (r) => SearchMovieLoaded(r),
        );
      }
      loadingBloc.add(FinishLoading());
    }
  }
}

part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final AppErrorType errorType;

  const SearchMovieError(this.errorType);
}

class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;

  const SearchMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
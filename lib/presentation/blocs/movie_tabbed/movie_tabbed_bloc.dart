import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_entity.dart';
import 'package:moviemix/domain/entities/no_params.dart';
import 'package:moviemix/domain/use_case/get_coming_soon.dart';
import 'package:moviemix/domain/use_case/get_playing_now.dart';
import 'package:moviemix/domain/use_case/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedBloc({
    @required this.getPopular,
    @required this.getPlayingNow,
    @required this.getComingSoon,
  }) : super(MovieTabbedInitial());

  @override
  Stream<MovieTabbedState> mapEventToState(
    MovieTabbedEvent event,
  ) async* {
    if (event is MovieTabChangedEvent) {
      yield MovieTabLoading(currentTabIndex: event.currentTabIndex);
      Either<AppError, List<MovieEntity>> moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getPopular(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNow(NoParams());
          break;
        case 2:
          moviesEither = await getComingSoon(NoParams());
          break;
      }
      // yield MovieTabLoadError(
      //   currentTabIndex: event.currentTabIndex,
      //   errorType: AppErrorType.network,
      // );
      yield moviesEither.fold(
        (l) => MovieTabLoadError(
            currentTabIndex: event.currentTabIndex, errorType: l.appErrorType),
        (movies) {
          return MovieTabChanged(
            currentTabIndex: event.currentTabIndex,
            movies: movies,
          );
        },
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_params.dart';
import 'package:moviemix/domain/entities/video_entity.dart';
import 'package:moviemix/domain/use_case/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({
    @required this.getVideos,
  }) : super(VideosInitial());

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {
    if (event is LoadVideosEvent) {
      final Either<AppError, List<VideoEntity>> eitherVideoResponse =
          await getVideos(MovieParams(event.movieId));

      yield eitherVideoResponse.fold(
        (l) => NoVideos(),
        (r) => VideosLoaded(r),
      );
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/movie_params.dart';
import 'package:moviemix/domain/entities/video_entity.dart';
import 'package:moviemix/domain/repositories/movie_repository.dart';
import 'package:moviemix/domain/use_case/use_case.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams> {
  final MovieRepository repository;

  GetVideos(this.repository);

  @override
  Future<Either<AppError, List<VideoEntity>>> call(
      MovieParams movieParams) async {
    return await repository.getVideos(movieParams.id);
  }
}

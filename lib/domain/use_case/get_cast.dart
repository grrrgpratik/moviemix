import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:moviemix/domain/entities/cast_entity.dart';
import 'package:moviemix/domain/entities/movie_params.dart';
import 'package:moviemix/domain/repositories/movie_repository.dart';
import 'package:moviemix/domain/use_case/use_case.dart';

class GetCast extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepository repository;

  GetCast(this.repository);

  @override
  Future<Either<AppError, List<CastEntity>>> call(
      MovieParams movieParams) async {
    return await repository.getCastCrew(movieParams.id);
  }
}

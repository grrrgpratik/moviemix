import 'package:moviemix/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/entities/no_params.dart';
import 'package:moviemix/domain/repositories/app_repository.dart';
import 'package:moviemix/domain/use_case/use_case.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetPreferredLanguage(this.appRepository);

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await appRepository.getPreferredLanguage();
  }
}

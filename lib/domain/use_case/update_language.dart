import 'package:moviemix/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/repositories/app_repository.dart';
import 'package:moviemix/domain/use_case/use_case.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepository appRepository;

  UpdateLanguage(this.appRepository);

  @override
  Future<Either<AppError, void>> call(String languageCode) async {
    return await appRepository.updateLanguage(languageCode);
  }
}

import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/use_case/use_case.dart';
import '../entities/app_error.dart';
import '../repositories/app_repository.dart';

class UpdateTheme extends UseCase<void, String> {
  final AppRepository appRepository;

  UpdateTheme(this.appRepository);

  @override
  Future<Either<AppError, void>> call(String themeName) async {
    return await appRepository.updateTheme(themeName);
  }
}

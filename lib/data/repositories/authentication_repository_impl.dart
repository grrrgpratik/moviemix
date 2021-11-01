import 'dart:io';

import 'package:moviemix/data/core/unathorised_exception.dart';
import 'package:moviemix/data/data_sources/authentication_local_data_source.dart';
import 'package:moviemix/data/data_sources/authentication_remote_data_source.dart';
import 'package:moviemix/data/models/request_token_model.dart';
import 'package:moviemix/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:moviemix/domain/repositories/authenticaton_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource,
      this._authenticationLocalDataSource);

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    //1
    final token1 =
        requestTokenEitherResponse.getOrElse(() => null)?.requestToken ?? '';
    try {
      body.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.toJson());
      print(sessionId);
      if (sessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        return Right(true);
      }
      return Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    //1
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    //2
    await Future.wait([
      _authenticationRemoteDataSource.deleteSession(sessionId),
      _authenticationLocalDataSource.deleteSessionId(),
    ]);
    print(await _authenticationLocalDataSource.getSessionId());
    //3
    return Right(Unit);
  }
}

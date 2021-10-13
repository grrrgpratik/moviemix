import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:moviemix/data/core/api_client.dart';
import 'package:moviemix/data/data_sources/movie_remote_data_source.dart';
import 'package:moviemix/data/repositories/movie_repository_impl.dart';
import 'package:moviemix/domain/repositories/movie_repository.dart';
import 'package:moviemix/domain/use_case/get_coming_soon.dart';
import 'package:moviemix/domain/use_case/get_playing_now.dart';
import 'package:moviemix/domain/use_case/get_popular.dart';
import 'package:moviemix/domain/use_case/get_trending.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));
}

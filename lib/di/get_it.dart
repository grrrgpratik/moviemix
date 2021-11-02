import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:moviemix/data/core/api_client.dart';
import 'package:moviemix/data/data_sources/authentication_local_data_source.dart';
import 'package:moviemix/data/data_sources/authentication_remote_data_source.dart';
import 'package:moviemix/data/data_sources/language_local_data_source.dart';
import 'package:moviemix/data/data_sources/movie_local_data_source.dart';
import 'package:moviemix/data/data_sources/movie_remote_data_source.dart';
import 'package:moviemix/data/repositories/app_repository_impl.dart';
import 'package:moviemix/data/repositories/authentication_repository_impl.dart';
import 'package:moviemix/data/repositories/movie_repository_impl.dart';
import 'package:moviemix/domain/repositories/app_repository.dart';
import 'package:moviemix/domain/repositories/authenticaton_repository.dart';
import 'package:moviemix/domain/repositories/movie_repository.dart';
import 'package:moviemix/domain/use_case/check_if_favorite_movie.dart';
import 'package:moviemix/domain/use_case/delete_favorite_movie.dart';
import 'package:moviemix/domain/use_case/get_cast.dart';
import 'package:moviemix/domain/use_case/get_coming_soon.dart';
import 'package:moviemix/domain/use_case/get_favorite_movies.dart';
import 'package:moviemix/domain/use_case/get_movie_detail.dart';
import 'package:moviemix/domain/use_case/get_playing_now.dart';
import 'package:moviemix/domain/use_case/get_popular.dart';
import 'package:moviemix/domain/use_case/get_preferred_language.dart';
import 'package:moviemix/domain/use_case/get_trending.dart';
import 'package:moviemix/domain/use_case/get_videos.dart';
import 'package:moviemix/domain/use_case/login_user.dart';
import 'package:moviemix/domain/use_case/logout_user.dart';
import 'package:moviemix/domain/use_case/save_movie.dart';
import 'package:moviemix/domain/use_case/search_movies.dart';
import 'package:moviemix/domain/use_case/update_language.dart';
import 'package:moviemix/presentation/blocs/cast/cast_bloc.dart';
import 'package:moviemix/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:moviemix/presentation/blocs/language/language_bloc.dart';
import 'package:moviemix/presentation/blocs/loading/loading_bloc.dart';
import 'package:moviemix/presentation/blocs/login/login_bloc.dart';
import 'package:moviemix/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:moviemix/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:moviemix/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:moviemix/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:moviemix/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:moviemix/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  //External
  getItInstance.registerLazySingleton<Client>(() => Client());

  //Core
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  //Data Source
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  //Repository
  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            getItInstance(),
            getItInstance(),
          ));
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        getItInstance(),
      ));
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  //Use Cases
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));
  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  //Bloc
  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
      loadingBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));
  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
      favoriteBloc: getItInstance(),
      loadingBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => CastBloc(
      getCast: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovies: getItInstance(),
      loadingBloc: getItInstance(),
    ),
  );
  getItInstance.registerFactory(() => FavoriteBloc(
        saveMovie: getItInstance(),
        checkIfFavoriteMovie: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
      ));
  getItInstance.registerFactory(() => LoginBloc(
      loginUser: getItInstance(),
      logoutUser: getItInstance(),
      loadingBloc: getItInstance()));

  getItInstance.registerLazySingleton(() => LoadingBloc());
}

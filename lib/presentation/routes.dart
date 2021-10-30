import 'package:flutter/material.dart';
import 'package:moviemix/common/constants/route_constants.dart';
import 'journeys/favorite/favorite.dart';
import 'journeys/home/home_screen.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';
import 'journeys/watch_video/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: setting.arguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: setting.arguments,
            ),
        RouteList.favorite: (context) => FavoriteScreen(),
      };
}

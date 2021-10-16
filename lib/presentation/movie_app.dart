import 'package:flutter/material.dart';
import 'package:moviemix/common/screenutil/screenutil.dart';
import 'journeys/home/home_screen.dart';
import 'themes/app_color.dart';
import 'themes/text_theme.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key key}) : super(key: key);

  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: HomeScreen(),
    );
  }
}

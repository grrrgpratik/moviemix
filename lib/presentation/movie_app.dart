import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/common/constants/route_constants.dart';
import 'package:moviemix/common/screenutil/screenutil.dart';
import 'package:moviemix/di/get_it.dart';
import 'package:moviemix/presentation/routes.dart';
import 'app_localization.dart';
import 'blocs/language/language_cubit.dart';
import 'blocs/loading/loading_cubit.dart';
import 'blocs/login/login_cubit.dart';
import 'blocs/theme/theme_cubit.dart';
import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';
import 'themes/app_color.dart';
import 'themes/text_theme.dart';
import 'wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageCubit _languageCubit;
  late LoginCubit _loginCubit;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginCubit = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _loginCubit.close();
    _loadingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(
          value: _languageCubit,
        ),
        BlocProvider<LoginCubit>.value(
          value: _loginCubit,
        ),
        BlocProvider<LoadingCubit>.value(
          value: _loadingCubit,
        ),
        BlocProvider<ThemeCubit>.value(
          value: _themeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return WiredashApp(
                navigatorKey: _navigatorKey,
                languageCode: locale.languageCode,
                child: MaterialApp(
                    navigatorKey: _navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: 'Movie App',
                    theme: ThemeData(
                      unselectedWidgetColor: AppColor.royalBlue,
                      accentColor: AppColor.royalBlue,
                      primaryColor:
                          theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      scaffoldBackgroundColor:
                          theme == Themes.dark ? AppColor.vulcan : Colors.white,
                      brightness: theme == Themes.dark
                          ? Brightness.dark
                          : Brightness.light,
                      cardTheme: CardTheme(
                        color: theme == Themes.dark
                            ? Colors.white
                            : AppColor.vulcan,
                      ),
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      textTheme: theme == Themes.dark
                          ? ThemeText.getTextTheme()
                          : ThemeText.getLightTextTheme(),
                      appBarTheme: AppBarTheme(
                        elevation: 0,
                        color: theme == Themes.dark
                            ? AppColor.vulcan
                            : Colors.white,
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        hintStyle: Theme.of(context).textTheme.greySubtitle1,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: theme == Themes.dark
                                ? Colors.white
                                : AppColor.vulcan,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    supportedLocales:
                        Languages.languages.map((e) => Locale(e.code)).toList(),
                    locale: locale,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    builder: (context, child) {
                      return LoadingScreen(
                        screen: child!,
                      );
                    },
                    initialRoute: RouteList.initial,
                    onGenerateRoute: (RouteSettings settings) {
                      final routes = Routes.getRoutes(settings);
                      final WidgetBuilder? builder = routes[settings.name];
                      return FadePageRouteBuilder(
                        builder: builder!,
                        settings: settings,
                      );
                    }),
              );
            },
          );
        },
      ),
    );
  }
}

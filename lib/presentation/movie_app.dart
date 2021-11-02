import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/common/constants/route_constants.dart';
import 'package:moviemix/common/screenutil/screenutil.dart';
import 'package:moviemix/di/get_it.dart';
import 'package:moviemix/presentation/routes.dart';
import 'app_localization.dart';
import 'blocs/language/language_bloc.dart';
import 'blocs/loading/loading_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';
import 'themes/app_color.dart';
import 'themes/text_theme.dart';
import 'wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key key}) : super(key: key);

  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  LanguageBloc _languageBloc;
  LoginBloc _loginBloc;
  LoadingBloc _loadingBloc;
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc?.close();
    _loadingBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(
          value: _languageBloc,
        ),
        BlocProvider<LoginBloc>.value(
          value: _loginBloc,
        ),
        BlocProvider<LoadingBloc>.value(
          value: _loadingBloc,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return WiredashApp(
              navigatorKey: _navigatorKey,
              languageCode: state.locale.languageCode,
              child: MaterialApp(
                  navigatorKey: _navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Movie App',
                  theme: ThemeData(
                      unselectedWidgetColor: AppColor.royalBlue,
                      primaryColor: AppColor.vulcan,
                      accentColor: AppColor.royalBlue,
                      scaffoldBackgroundColor: AppColor.vulcan,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      textTheme: ThemeText.getTextTheme(),
                      appBarTheme: const AppBarTheme(elevation: 0),
                      cardTheme: CardTheme(color: Colors.white),
                      brightness: Brightness.dark),
                  supportedLocales:
                      Languages.languages.map((e) => Locale(e.code)).toList(),
                  locale: state.locale,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) {
                    return LoadingScreen(
                      screen: child,
                    );
                  },
                  initialRoute: RouteList.initial,
                  onGenerateRoute: (RouteSettings settings) {
                    final routes = Routes.getRoutes(settings);
                    final WidgetBuilder builder = routes[settings.name];
                    return FadePageRouteBuilder(
                      builder: builder,
                      settings: settings,
                    );
                  }),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

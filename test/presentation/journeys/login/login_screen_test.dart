import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/common/screenutil/screenutil.dart';
import 'package:moviemix/presentation/app_localization.dart';
import 'package:moviemix/presentation/blocs/language/language_cubit.dart';
import 'package:moviemix/presentation/blocs/loading/loading_cubit.dart';
import 'package:moviemix/presentation/blocs/login/login_cubit.dart';
import 'package:moviemix/presentation/journeys/login/login_form.dart';
import 'package:moviemix/presentation/journeys/login/login_screen.dart';
import 'package:moviemix/presentation/widgets/logo.dart';

class LanguageCubitMock extends Mock implements LanguageCubit {}

class LoginCubitMock extends Mock implements LoginCubit {}

class LoadingCubitMock extends Mock implements LoadingCubit {}

main() {
  Widget app;
  LanguageCubitMock _languageCubitMock;
  LoginCubitMock _loginCubitMock;
  LoadingCubitMock _loadingCubitMock;

  setUp(() {
    _languageCubitMock = LanguageCubitMock();
    _loginCubitMock = LoginCubitMock();
    _loadingCubitMock = LoadingCubitMock();

    ScreenUtil.init();
    app = MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubitMock),
        BlocProvider<LoginCubit>.value(value: _loginCubitMock),
        BlocProvider<LoadingCubit>.value(value: _loadingCubitMock),
      ],
      child: MaterialApp(
        locale: Locale(Languages.languages[0].code),
        supportedLocales:
            Languages.languages.map((e) => Locale(e.code)).toList(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: LoginScreen(),
      ),
    );
  });

  tearDown(() {
    _loginCubitMock.close();
    _loadingCubitMock.close();
    _languageCubitMock.close();
  });

  testWidgets('should show basic login screen UI login form and logo',
      (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.byType(Logo), findsOneWidget);
    expect(find.byType(LoginForm), findsOneWidget);
  });
}

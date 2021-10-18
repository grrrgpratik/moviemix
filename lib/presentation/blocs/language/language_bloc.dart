import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviemix/common/constants/language.dart';
import 'package:moviemix/domain/entities/language_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(
          LanguageLoaded(
            Locale(Languages.languages.first.code),
          ),
        );

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ToggleLanguageEvent) {
      yield LanguageLoaded(Locale(event.language.code));
    }
  }
}

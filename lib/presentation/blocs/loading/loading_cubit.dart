import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);
  void show() => emit(true);
  void hide() => emit(false);
}

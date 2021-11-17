import 'package:bloc/bloc.dart';
import 'package:moviemix/domain/entities/movie_entity.dart';

class MovieBackdropCubit extends Cubit<MovieEntity?> {
  MovieBackdropCubit() : super(null);

  void backdropChanged(MovieEntity movie) {
    emit(movie);
  }
}

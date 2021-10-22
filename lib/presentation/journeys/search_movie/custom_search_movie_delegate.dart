import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviemix/common/constants/size_constants.dart';
import 'package:moviemix/common/constants/translation_constants.dart';
import 'package:moviemix/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:moviemix/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:moviemix/presentation/themes/app_color.dart';
import 'package:moviemix/presentation/widgets/app_error_widget.dart';
import 'package:moviemix/common/extension/size_extension.dart';
import 'package:moviemix/common/extension/string_extension.dart';
import 'package:moviemix/presentation/themes/text_theme.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.vulcan,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.vulcan)),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          size: Sizes.dimen_12.h,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
        onPressed: query.isEmpty ? null : () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: Sizes.dimen_10.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(
      SearchTermChangedEvent(query),
    );

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: searchMovieBloc,
      builder: (context, state) {
        if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.errorType,
            onPressed: () =>
                searchMovieBloc?.add(SearchTermChangedEvent(query)),
          );
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                child: Text(
                  TranslationConstants.noMoviesSearched.t(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => SearchMovieCard(
              movie: movies[index],
            ),
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}

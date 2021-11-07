import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviemix/common/constants/route_constants.dart';
import 'package:moviemix/common/constants/translation_constants.dart';
import 'package:moviemix/presentation/blocs/videos/videos_cubit.dart';
import 'package:moviemix/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:moviemix/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:moviemix/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosCubit videosCubit;

  const VideosWidget({
    Key key,
    this.videosCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: videosCubit,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(RouteList.watchTrailer,
                  arguments: WatchVideoArguments(_videos));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

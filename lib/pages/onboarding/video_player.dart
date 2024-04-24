import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

  final String videoURL;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      progressIndicatorColor: Theme.of(context).colorScheme.primary,
      controller: YoutubePlayerController(
        initialVideoId: videoURL,
      ),
      aspectRatio: 16 / 9,
      showVideoProgressIndicator: true,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.white,
      ),
      liveUIColor: Colors.red,
    );
  }
}

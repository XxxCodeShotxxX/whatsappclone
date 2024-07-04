import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PausePlayButton extends StatelessWidget {
  const PausePlayButton({
    super.key,
    required this.videoPlayerController,
  });

  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black38,
      child: Icon(
        videoPlayerController.value.isPlaying
            ? Icons.pause
            : Icons.play_arrow,
        size: 50,
      ),
    );
  }
}

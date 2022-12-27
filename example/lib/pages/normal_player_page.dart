import 'package:better_player/better_player.dart';
import 'package:better_player_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalPlayerPage extends StatefulWidget {
  @override
  _NormalPlayerPageState createState() => _NormalPlayerPageState();
}

class _NormalPlayerPageState extends State<NormalPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,

      autoPlay: true,
      looping: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        controlBarColor: Colors.black26.withOpacity(0.5),
        onAddNote: () {
          _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
        },
        enablePlayPause: false,
        enableSubtitles: true,
        playIcon: Icons.play_arrow_rounded,
        progressBarPlayedColor: Colors.blueAccent,
        overflowMenuCustomItems: [
          BetterPlayerOverflowMenuItem(
            title: "Subtitles",
            onClicked: () {
              print("Add note clicked");
            },
            trailing: Icon(Icons.subtitles_outlined),
          ),
          BetterPlayerOverflowMenuItem(
            title: "Video Language",
            onClicked: () {
              print("Add note clicked");
            },
            trailing: Icon(Icons.language_outlined),
          ),
          BetterPlayerOverflowMenuItem(
            title: "Enter Picture in Picture",
            onClicked: () {
              _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
            },
            trailing: Text(""),
          ),
        ],
      ),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ],
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.forBiggerBlazesUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normal player page"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}

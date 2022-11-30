import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DetailVideo extends StatefulWidget {
  final String? fileName;

  const DetailVideo({Key? key, this.fileName}) : super(key: key);

  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File('${widget.fileName}'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _disposeVideo(),
      child: Scaffold(
        body: Chewie(
          controller: ChewieController(
              videoPlayerController: _videoPlayerController!,
              looping: false,
              autoInitialize: true,
              allowedScreenSleep: false,
              fullScreenByDefault: true,
              autoPlay: true,
              showControlsOnInitialize: false,
              errorBuilder: (context, errorMessage) {
                return Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
        )
      ),
    );
  }

  _disposeVideo() {
    _videoPlayerController?.pause();
    _chewieController?.pause();
    Navigator.pop(context);
  }
}

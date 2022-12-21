import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/download _video/download_video_bloc.dart';

class DetailVideo extends StatefulWidget {
  final String? fileName;
  final String? articleUrl;
  final String? idArticle;

  const DetailVideo({Key? key, this.fileName, this.articleUrl, this.idArticle}) : super(key: key);

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
    if(widget.fileName == null){
      BlocProvider.of<DownloadVideoBloc>(context).add(DownloadVideo(urlVideo: '${widget.articleUrl}', idArticle: '${widget.idArticle}'));
    }else{
      _videoPlayerController = VideoPlayerController.file(File('${widget.fileName}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _disposeVideo(),
      child: widget.fileName == null
          ? BlocBuilder<DownloadVideoBloc, DownloadVideoState>(
          builder: (context, state){
            if(state.status.isLoading){
              return Scaffold(
                body: Stack(
                  children: [
                    const Center(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Center(
                      child: Text(state.progress ?? '-'   ),
                    )
                  ],
                ),
              );
            }
            return Scaffold(
                body: Chewie(
                  controller: ChewieController(
                      videoPlayerController: VideoPlayerController.file(File('${state.fileVideoPath}')),
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
            );
          }
      )
          : Scaffold(
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

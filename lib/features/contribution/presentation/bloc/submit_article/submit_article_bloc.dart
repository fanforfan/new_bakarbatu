import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/contribution/domain/usecases/contribution_usecase.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

part 'submit_article_event.dart';
part 'submit_article_state.dart';

class SubmitArticleBloc extends Bloc<SubmitArticleEvent, SubmitArticleState> {
  final ContributionUsecase contributionUsecase;

  SubmitArticleBloc({required this.contributionUsecase}) : super(const SubmitArticleState()) {
    on<PickVideo>(_getVideoCamera);
    on<PickAudio>(_getAudioRecorder);
  }


  _getVideoCamera(PickVideo event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
      status: SubmitStateStatus.loading
    ));

    try{
      var thumbnailFile = await VideoCompress.getFileThumbnail(event.videoFile!.path, quality: 50, position: -1);
      var video = File(event.videoFile!.path);

      var videoPlayerController = VideoPlayerController.file(video);
      await videoPlayerController.initialize();
      await videoPlayerController.pause();

      var chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          looping: false,
          autoInitialize: true,
          allowedScreenSleep: false,
          autoPlay: false,
          showControlsOnInitialize: false,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          });

      emit(state.copyWith(
        videoFile: video,
        thumbnailVideo: thumbnailFile,
        chewieController: chewieController,
        videoController: videoPlayerController
      ));
    } catch (error) {
      debugPrint('ERROR PROSESS : $error');
    }
  }

  _getAudioRecorder(PickAudio event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
      audioFile: event.audioFile
    ));
  }

}

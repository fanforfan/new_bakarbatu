import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/article_request_entity.dart';
import '../../../domain/usecases/contribution_usecase.dart';

part 'submit_artikel_video_event.dart';
part 'submit_artikel_video_state.dart';

class SubmitArtikelVideoBloc extends Bloc<SubmitArtikelVideoEvent, SubmitArticleVideoState> {
  final ContributionUsecase contributionUsecase;

  SubmitArtikelVideoBloc({required this.contributionUsecase}) : super(const SubmitArticleVideoState()) {
    on<PickVideoFile>(_getVideoCamera);
    on<ChangeTimeScheduleVid>((event, emit) => emit(
        state.copyWith(
          timeScheduleVid: event.value,
        )
    ));
    on<ChangeJudulIndonesiaVid>((event, emit) => emit(
        state.copyWith(
          judulIndonesiaVid: event.value,
        )
    ));
    on<ChangeCaptionIndonesiaVid>((event, emit) => emit(
        state.copyWith(
          captionIndonesiaVid: event.value,
        )
    ));
    on<ChangeDeskripsiIndonesiaVid>((event, emit) => emit(
        state.copyWith(
          deskripsiIndonesiaVid: event.value,
        )
    ));
    on<ChangeKabutapenVid>((event, emit) => emit(
        state.copyWith(
          tagKabupatenVid: event.value,
        )
    ));
    on<ChangeKampungVid>((event, emit) => emit(
        state.copyWith(
          tagKampungVid: event.value,
        )
    ));
    on<ChangeDistrikVid>((event, emit) => emit(
        state.copyWith(
          tagDistrikVid: event.value,
        )
    ));
    on<ChangeHideAuthorVid>((event, emit) => emit(
        state.copyWith(
          hideAuthor: event.value,
        )
    ));
    on<ValidateToSubmitArticleVid>(_submitArticle);
    on<ClearFormVid>((event, emit) {
      emit(
          state.copyWith(
              status: SubmitVideoStateStatus.initial,
              timeScheduleVid: '',
              judulIndonesiaVid: '',
              captionIndonesiaVid: '',
              deskripsiIndonesiaVid: '',
              tagKabupatenVid: '',
              tagKampungVid: '',
              tagDistrikVid: ''
          )
      );
    });
  }

  _getVideoCamera(PickVideoFile event, Emitter<SubmitArticleVideoState> emit) async {
    try{
      var thumbnailFile = await VideoCompress.getFileThumbnail(event.videoFile!.path, quality: 100, position: -1);
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

  _submitArticle(ValidateToSubmitArticleVid event, Emitter<SubmitArticleVideoState> emit) async {
    emit(state.copyWith(
        status: SubmitVideoStateStatus.loading
    ));

    try{
      if(state.videoFile == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Pick an image please.'
        ));
      }else if(state.timeScheduleVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Time schedule belum terisi.'
        ));
      }else if(state.judulIndonesiaVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Judul Indonesia belum terisi.'
        ));
      }else if(state.captionIndonesiaVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Caption Indonesia belum terisi.'
        ));
      }else if(state.deskripsiIndonesiaVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Deskripsi/Detail Indonesa belum terisi.'
        ));
      }else if(state.tagKabupatenVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Tag Kabupaten belum terisi.'
        ));
      }else if(state.tagKampungVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Tag Kampung belum terisi.'
        ));
      }else if(state.tagDistrikVid == null){
        emit(state.copyWith(
            status: SubmitVideoStateStatus.error,
            warningMessageVid: 'Tag distrik belum terisi.'
        ));
      }else{
        var date = DateTime.now();
        var mainDirectory = await getApplicationDocumentsDirectory();
        var path = mainDirectory.path;
        var fileName = "Bakar_Batu_${state.judulIndonesiaVid!.replaceAll(' ', '_')}_${date.toString().replaceAll(' ', '').replaceAll('.', '').replaceAll('-', '').replaceAll('/', '').replaceAll(':', '')}.mp4";
        var newVideo = await File(state.videoFile!.path).copy("$path/$fileName");

        var data = ArticleRequestEntity(
            articleFile: newVideo,
            jenisFile: 2,
            timeSchedule: state.timeScheduleVid,
            judulIndonesia: state.judulIndonesiaVid,
            captionIndonesia: state.captionIndonesiaVid,
            deskripsiIndonesia: state.deskripsiIndonesiaVid,
            tagKabupaten: state.tagKabupatenVid,
            tagKampung: state.tagKampungVid,
            tagDistrik: state.tagDistrikVid,
            hideAuthor: state.hideAuthor ?? true
        );

        var connectivityResult = await (Connectivity().checkConnectivity());

        if(connectivityResult == ConnectivityResult.none){
          var response = await contributionUsecase.saveToLocalArticle(data: data);

          if(response!){
            emit(state.copyWith(
                status: SubmitVideoStateStatus.success
            ));
            if(state.status.isSuccess){
              emit(state.copyWith(
                  status: SubmitVideoStateStatus.initial
              ));
            }
          }else{
            emit(state.copyWith(
                status: SubmitVideoStateStatus.error
            ));
          }
        }else{
          print('MASUKAN KE SERVER');
          var response = await contributionUsecase.saveToServerArticleVideo(data: data);
          if(response!){
            emit(state.copyWith(
                status: SubmitVideoStateStatus.success
            ));
            if(state.status.isSuccess){
              emit(state.copyWith(
                  status: SubmitVideoStateStatus.initial
              ));
            }
          }else{
            emit(state.copyWith(
                status: SubmitVideoStateStatus.error
            ));
          }
        }
      }
    }catch (error){
      debugPrint('ERROR PROSESS : $error');
      emit(state.copyWith(
          status: SubmitVideoStateStatus.error,
          warningMessageVid: '$error'
      ));
    }
  }
}

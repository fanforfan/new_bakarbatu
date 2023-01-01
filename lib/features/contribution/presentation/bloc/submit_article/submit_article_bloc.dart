import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:new_bakarbatu/features/contribution/domain/entities/article_request_entity.dart';
import 'package:new_bakarbatu/features/contribution/domain/usecases/contribution_usecase.dart';
import 'package:new_bakarbatu/shared/common/key_language.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

part 'submit_article_event.dart';
part 'submit_article_state.dart';

class SubmitArticleBloc extends Bloc<SubmitArticleEvent, SubmitArticleState> {
  final ContributionUsecase contributionUsecase;

  SubmitArticleBloc({required this.contributionUsecase}) : super(const SubmitArticleState()) {
    on<PickVideo>(_getVideoCamera);
    on<PickAudio>(_getAudioRecorder);
  /// Basic Article
    on<ChangeTitleArticle>((event, emit) => emit(state.copyWith(
      titleArticle: event.value
    )));
    on<ChangeDescriptionArticle>((event, emit) => emit(state.copyWith(
        descriptionArticle: event.value
    )));
    on<ChangeHideShowAuthor>((event, emit) => emit(state.copyWith(
        hideAuthor: event.value
    )));
    on<GetImageArticle>((event, emit) =>
        emit(state.copyWith(
          photoFile: event.imageFile,
        ))
    );
    on<GetImageArticleEdited>((event, emit) =>
        emit(state.copyWith(
          editPhotoFile: event.imageFile,
        ))
    );
    on<ChangeTimeSchedule>((event, emit) => emit(
        state.copyWith(
          timeSchedule: event.value,
        )
    ));
    on<ChangeJudulIndonesia>((event, emit) => emit(
        state.copyWith(
          judulIndonesiaIMG: event.value,
        )
    ));
    on<ChangeCaptionIndonesia>((event, emit) => emit(
        state.copyWith(
          captionIndonesiaIMG: event.value,
        )
    ));
    on<ChangeDeskripsiIndonesia>((event, emit) => emit(
        state.copyWith(
          deskripsiIndonesiaIMG: event.value,
        )
    ));
    on<ChangeKabutapen>((event, emit) => emit(
        state.copyWith(
          tagKabupatenIMG: event.value,
        )
    ));
    on<ChangeKampung>((event, emit) => emit(
        state.copyWith(
          tagKampungIMG: event.value,
        )
    ));
    on<ChangeDistrik>((event, emit) => emit(
        state.copyWith(
          tagDistrikIMG: event.value,
        )
    ));
    on<ChangeHideAuthor>((event, emit) => emit(
        state.copyWith(
          hideAuthor: event.value,
        )
    ));
    on<ClearFormIMG>((event, emit) {
      emit(
          state.copyWith(
              status: SubmitStateStatus.initial,
              photoFile: XFile(''),
              photoFileEdited: XFile(''),
              timeSchedule: '',
              judulIndonesiaIMG: '',
              captionIndonesiaIMG: '',
              deskripsiIndonesiaIMG: '',
              tagKabupatenIMG: '',
              tagKampungIMG: '',
              tagDistrikIMG: ''
          )
      );
    });
    
    on<ValidateToSubmitArticle>(_submitArticle);
    on<SubmitArticleBasic>(_submitArticleBasic);
    on<SaveUpdateToLocalArticle>(_saveUpdateArticle);
    on<LocalToServer>(_sendLocalToServer);

    on<SetDetailArticleToEdit>((event, emit) {
      emit(state.copyWith(
          editPhotoFile: XFile('${event.data?.filename}'),
          editTimeSchedule: '${event.data?.timeSchedule}',
          editJudulIndonesia: '${event.data?.judulIndonesia}',
          editCaptionIndonesia: '${event.data?.captionIndonesia}',
          editDeskripsiIndonesia: '${event.data?.deskripsiIndonesia}',
          editTagKabupaten: '${event.data?.tagKabupaten}',
          editTagKampung: '${event.data?.tagKampung}',
          editTagDistrik: '${event.data?.tagDistrik}',
          edithideAuthor: event.data?.hideAuthor
      ));
    });

    on<SetDetailArticleOnline>((event, emit) {
      emit(state.copyWith(
        detailPathUrl: event.data?.articleUrl ?? '',
        detailTimeSchedule: event.data?.saved ?? '',
        detailJudul: event.data?.title ?? '',
        detailCaption: event.data?.categoryName ?? '',
        detailDeskripsi: event.data?.description ?? '',
      ));
    });

  ///UNTUK EDIT IMAGE
    on<EditChangeTimeSchedule>((event, emit) => emit(
        state.copyWith(
          editTimeSchedule: event.value,
        )
    ));
    on<EditChangeJudulIndonesia>((event, emit) => emit(
        state.copyWith(
          editJudulIndonesia: event.value,
        )
    ));
    on<EditChangeCaptionIndonesia>((event, emit) => emit(
        state.copyWith(
          editCaptionIndonesia: event.value,
        )
    ));
    on<EditChangeDeskripsiIndonesia>((event, emit) => emit(
        state.copyWith(
          editDeskripsiIndonesia: event.value,
        )
    ));
    on<EditChangeKabutapen>((event, emit) => emit(
        state.copyWith(
          editTagKabupaten: event.value,
        )
    ));
    on<EditChangeKampung>((event, emit) => emit(
        state.copyWith(
          editTagKampung: event.value,
        )
    ));
    on<EditChangeDistrik>((event, emit) => emit(
        state.copyWith(
          editTagDistrik: event.value,
        )
    ));
    on<EditChangeHideAuthor>((event, emit) => emit(
        state.copyWith(
          hideAuthor: event.value,
        )
    ));
  }

  _getVideoCamera(PickVideo event, Emitter<SubmitArticleState> emit) async {
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
      debugPrint('ERROR PROSESS BLOC : $error');
    }
  }

  _getAudioRecorder(PickAudio event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
      audioFile: event.audioFile
    ));
  }

  _submitArticleBasic(SubmitArticleBasic event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
        status: SubmitStateStatus.loading
    ));
    try{
      await contributionUsecase.localSubmitArtikel(event.article);
      emit(state.copyWith(
        status: SubmitStateStatus.success
      ));
    }catch (error) {
      debugPrint('ERROR PROSESS : $error');
      emit(state.copyWith(
          status: SubmitStateStatus.error
      ));
    }
  }

  _submitArticle(ValidateToSubmitArticle event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
        status: SubmitStateStatus.loading
    ));
    try{
      if(state.photoFile == null){
        emit(state.copyWith(
          status: SubmitStateStatus.error,
          warningMessage: KeyLanguage.warningMsgImage
        ));
      }else if(state.timeSchedule == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgTime
        ));
      }else if(state.judulIndonesiaIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgJudul
        ));
      }else if(state.captionIndonesiaIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgJudul
        ));
      }else if(state.deskripsiIndonesiaIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgDeskripsi
        ));
      }else if(state.tagKabupatenIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgKabupaten
        ));
      }else if(state.tagKampungIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgKampung
        ));
      }else if(state.tagDistrikIMG == null){
        emit(state.copyWith(
            status: SubmitStateStatus.error,
            warningMessage: KeyLanguage.warningMsgDistrik
        ));
      }else{
        var date = DateTime.now();
        var mainDirectory = await getApplicationDocumentsDirectory();
        var path = mainDirectory.path;
        var fileName = "Bakar_Batu_${state.judulIndonesiaIMG!.replaceAll(' ', '_')}_${date.toString().replaceAll(' ', '').replaceAll('.', '').replaceAll('-', '').replaceAll('/', '').replaceAll(':', '')}.jpg";
        var newImage = await File(state.photoFile!.path).copy("$path/$fileName");

        var data = ArticleRequestEntity(
            articleFile: newImage,
            jenisFile: 1,
            timeSchedule: state.timeSchedule,
            judulIndonesia: state.judulIndonesiaIMG,
            captionIndonesia: state.captionIndonesiaIMG,
            deskripsiIndonesia: state.deskripsiIndonesiaIMG,
            tagKabupaten: state.tagKabupatenIMG,
            tagKampung: state.tagKampungIMG,
            tagDistrik: state.tagDistrikIMG,
            hideAuthor: state.hideAuthor ?? true
        );

        var connectivityResult = await (Connectivity().checkConnectivity());

        if(connectivityResult == ConnectivityResult.none){
          var response = await contributionUsecase.saveToLocalArticle(data: data);
          if(response!){
            emit(state.copyWith(
                status: SubmitStateStatus.success
            ));
            if(state.status.isSuccess){
              emit(state.copyWith(
                  status: SubmitStateStatus.initial
              ));
            }
          }else{
            emit(state.copyWith(
                status: SubmitStateStatus.error
            ));
          }
        }
        else{
          var response = await contributionUsecase.saveToServerArticle(data: data);
          if(response!){
            emit(state.copyWith(
                status: SubmitStateStatus.success
            ));
            if(state.status.isSuccess){
              emit(state.copyWith(
                  status: SubmitStateStatus.initial
              ));
            }
          }else{
            emit(state.copyWith(
                status: SubmitStateStatus.error
            ));
          }
        }
      }
    }catch (error){
      debugPrint('ERROR PROSESS : $error');
      emit(state.copyWith(
          status: SubmitStateStatus.error
      ));
    }
  }

  _saveUpdateArticle(SaveUpdateToLocalArticle event, Emitter<SubmitArticleState> emit) async {
    emit(state.copyWith(
        status: SubmitStateStatus.loading
    ));

    try{

      // File fileArticle;
      //
      // if(state.photoFileEdited != null){
      //   if(state.photoFileEdited!.path != event.fileExisting){
      //     fileArticle = File(state.photoFileEdited!.path);
      //   }else{
      //     fileArticle = File('${event.fileExisting}');
      //   }
      // }else{
      //   fileArticle = File('${event.fileExisting}');
      // }

      var data = ArticleRequestEntity(
          articleFile: File('${state.editPhotoFile?.path}'),
          jenisFile: 1,
          timeSchedule: state.editTimeSchedule,
          judulIndonesia: state.editJudulIndonesia,
          captionIndonesia: state.editCaptionIndonesia,
          deskripsiIndonesia: state.editDeskripsiIndonesia,
          tagKabupaten: state.editTagKabupaten,
          tagKampung: state.editTagKampung,
          tagDistrik: state.editTagDistrik,
          hideAuthor: state.edithideAuthor ?? true
      );

      var response = await contributionUsecase.saveUpdateToLocalArticle(data: data, collectionKey: event.collectionKey);
      if(response!){
        emit(state.copyWith(
            status: SubmitStateStatus.success
        ));
        if(state.status.isSuccess){
          emit(state.copyWith(
              status: SubmitStateStatus.initial
          ));
        }
      }else{
        emit(state.copyWith(
            status: SubmitStateStatus.error
        ));
      }

    }catch (error){
      debugPrint('ERROR PROSESS BLOC : $error');
      emit(state.copyWith(
          status: SubmitStateStatus.error
      ));
    }
  }

  _sendLocalToServer(LocalToServer event, Emitter<SubmitArticleState> emit) async {
    print('SAMPAI GAK?');
    try{
      emit(state.copyWith(
          statusDelete: SubmitStateStatus.loading
      ));
      var data = ArticleRequestEntity(
          articleFile: File('${event.data?.filename}'),
          jenisFile: 1,
          timeSchedule: event.data?.timeSchedule,
          judulIndonesia: event.data?.judulIndonesia,
          captionIndonesia: event.data?.captionIndonesia,
          deskripsiIndonesia: event.data?.deskripsiIndonesia,
          tagKabupaten: event.data?.tagKabupaten,
          tagKampung: event.data?.tagKampung,
          tagDistrik: event.data?.tagDistrik,
          hideAuthor: event.data?.hideAuthor ?? true
      );
      var response = await contributionUsecase.saveToServerArticle(data: data);
      if(response!){
        print('UPLOAD BERHASIL : ${event.data?.collectionKey}');
        var deleted = await contributionUsecase.deleteLocalArticle(collectionKey: event.data?.collectionKey);
        if(deleted!){
          emit(state.copyWith(
            statusDelete: SubmitStateStatus.success
          ));
          if(state.statusDelete.isSuccess){
            emit(state.copyWith(
                statusDelete: SubmitStateStatus.initial
            ));
          }
        }else{
          emit(state.copyWith(
              statusDelete: SubmitStateStatus.error
          ));
        }
      }else{
        print('UPLOAD GAGAL : $response');
        emit(state.copyWith(
            statusDelete: SubmitStateStatus.error
        ));
      }
    }catch (error){
      print('BLOC : $error');
      emit(state.copyWith(
          statusDelete: SubmitStateStatus.error
      ));
    }
  }
}

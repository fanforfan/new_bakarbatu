import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'download_video_event.dart';
part 'download_video_state.dart';

class DownloadVideoBloc extends Bloc<DownloadVideoEvent, DownloadVideoState> {
  DownloadVideoBloc() : super(const DownloadVideoState()) {
    on<DownloadVideo>((event, emit) async {
      Dio dio = Dio();
      try{
        emit(state.copyWith(
          status: DownloadStatus.loading,
          idLoading: event.idArticle
        ));
        var dir = await getApplicationDocumentsDirectory();

        await dio.download(event.urlVideo, "${dir.path}/${event.idArticle}.mp4",
            onReceiveProgress: (rec, total) {
              print("Rec: $rec , Total: $total PERCENT : ${((rec / total) * 100).toStringAsFixed(0)} %");
              if(rec != total){
                emit(state.copyWith(
                  progress: '${((rec / total) * 100).toStringAsFixed(0)} %'
                ));
              }else{
                emit(
                    state.copyWith(
                        status: DownloadStatus.success,
                        fileVideoPath: '${dir.path}/${event.idArticle}.mp4',
                    )
                );
              }
            });

        if(state.status == DownloadStatus.success){
          emit(state.copyWith(
            status: DownloadStatus.initial,
            progress: '0 %'
          ));
        }
      }catch (error){
        print('BLOC : $error');
      }
    });
  }
}

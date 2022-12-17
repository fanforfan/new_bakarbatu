part of 'download_video_bloc.dart';

abstract class DownloadVideoEvent extends Equatable {
  const DownloadVideoEvent();
}

class DownloadVideo extends DownloadVideoEvent {
  final String urlVideo;
  final String idArticle;

  const DownloadVideo({
    required this.urlVideo,
    required this.idArticle});

  @override
  // TODO: implement props
  List<Object?> get props => [urlVideo, idArticle];
}

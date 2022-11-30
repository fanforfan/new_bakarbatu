part of 'submit_artikel_video_bloc.dart';

enum SubmitVideoStateStatus { initial, success, error, loading }

extension SubmitVideoStateStatusX on SubmitVideoStateStatus {
  bool get isInitial => this == SubmitVideoStateStatus.initial;
  bool get isSuccess => this == SubmitVideoStateStatus.success;
  bool get isError => this == SubmitVideoStateStatus.error;
  bool get isLoading => this == SubmitVideoStateStatus.loading;
}

class SubmitArticleVideoState extends Equatable {
  final SubmitVideoStateStatus status;
  final File? videoFile;
  final XFile? photoFile;
  final bool? hideAuthor;
  final File? thumbnailVideo;
  final VideoPlayerController? videoController;
  final ChewieController? chewieController;
  /// FOR VIDEO
  final String? timeScheduleVid;
  final String? judulIndonesiaVid;
  final String? captionIndonesiaVid;
  final String? deskripsiIndonesiaVid;
  final String? tagKabupatenVid;
  final String? tagKampungVid;
  final String? tagDistrikVid;
  /// FOR WARNING IMAGE
  final String? warningMessageVid;


  const SubmitArticleVideoState({
    this.status = SubmitVideoStateStatus.initial,
    this.videoFile,
    this.photoFile,
    this.hideAuthor,
    this.thumbnailVideo,
    this.chewieController,
    this.videoController,
    this.timeScheduleVid,
    this.judulIndonesiaVid,
    this.captionIndonesiaVid,
    this.deskripsiIndonesiaVid,
    this.tagKabupatenVid,
    this.tagKampungVid,
    this.tagDistrikVid,
    this.warningMessageVid,
  });

  @override
  List<Object?> get props => [
    status,
    videoFile,
    photoFile,
    hideAuthor,
    thumbnailVideo,
    chewieController,
    videoController,
    timeScheduleVid,
    judulIndonesiaVid,
    captionIndonesiaVid,
    deskripsiIndonesiaVid,
    tagKabupatenVid,
    tagKampungVid,
    tagDistrikVid,
    warningMessageVid,
  ];

  SubmitArticleVideoState copyWith({
    SubmitVideoStateStatus? status,
    File? videoFile,
    XFile? photoFile,
    bool? hideAuthor,
    File? thumbnailVideo,
    VideoPlayerController? videoController,
    ChewieController? chewieController,
    /// FOR VIDEO
    String? timeScheduleVid,
    String? judulIndonesiaVid,
    String? captionIndonesiaVid,
    String? deskripsiIndonesiaVid,
    String? tagKabupatenVid,
    String? tagKampungVid,
    String? tagDistrikVid,
    /// FOR WARNING IMAGE
    String? warningMessageVid
  }) {
    return SubmitArticleVideoState(
      status: status ?? this.status,
      videoFile: videoFile ?? this.videoFile,
      photoFile: photoFile ?? this.photoFile,
      hideAuthor: hideAuthor ?? this.hideAuthor,
      thumbnailVideo: thumbnailVideo ?? this.thumbnailVideo,
      chewieController: chewieController ?? this.chewieController,
      videoController: videoController ?? this.videoController,
      timeScheduleVid: timeScheduleVid ?? this.timeScheduleVid,
      judulIndonesiaVid: judulIndonesiaVid ?? this.judulIndonesiaVid,
      captionIndonesiaVid: captionIndonesiaVid ?? this.captionIndonesiaVid,
      deskripsiIndonesiaVid: deskripsiIndonesiaVid ?? this.deskripsiIndonesiaVid,
      tagKabupatenVid: tagKabupatenVid ?? this.tagKabupatenVid,
      tagKampungVid: tagKampungVid ?? this.tagKampungVid,
      tagDistrikVid: tagDistrikVid ?? this.tagDistrikVid,
      warningMessageVid: warningMessageVid ?? this.warningMessageVid,
    );
  }
}


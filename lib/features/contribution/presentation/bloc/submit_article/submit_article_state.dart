part of 'submit_article_bloc.dart';

enum SubmitStateStatus { initial, success, error, loading }

extension SubmitStateStatusX on SubmitStateStatus {
  bool get isInitial => this == SubmitStateStatus.initial;
  bool get isSuccess => this == SubmitStateStatus.success;
  bool get isError => this == SubmitStateStatus.error;
  bool get isLoading => this == SubmitStateStatus.loading;
}

class SubmitArticleState extends Equatable {
  final SubmitStateStatus status;
  final File? videoFile;
  final XFile? photoFile;
  final String? titleArticle;
  final String? descriptionArticle;
  final bool? hideAuthor;
  final File? thumbnailVideo;
  final VideoPlayerController? videoController;
  final ChewieController? chewieController;
  /// FOR AUDIO RECORDER
  final File? audioFile;
  /// FOR IMAGE
  final String? timeSchedule;
  final String? judulIndonesiaIMG;
  final String? captionIndonesiaIMG;
  final String? deskripsiIndonesiaIMG;
  final String? tagKabupatenIMG;
  final String? tagKampungIMG;
  final String? tagDistrikIMG;
  /// FOR WARNING IMAGE
  final String? warningMessage;
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


  const SubmitArticleState({
    this.status = SubmitStateStatus.initial,
    this.videoFile,
    this.photoFile,
    this.titleArticle,
    this.descriptionArticle,
    this.hideAuthor,
    this.thumbnailVideo,
    this.chewieController,
    this.videoController,
    this.audioFile,
    this.timeSchedule,
    this.judulIndonesiaIMG,
    this.captionIndonesiaIMG,
    this.deskripsiIndonesiaIMG,
    this.tagKabupatenIMG,
    this.tagKampungIMG,
    this.tagDistrikIMG,
    this.warningMessage,
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
    titleArticle,
    descriptionArticle,
    hideAuthor,
    thumbnailVideo,
    chewieController,
    videoController,
    audioFile,
    timeSchedule,
    judulIndonesiaIMG,
    captionIndonesiaIMG,
    deskripsiIndonesiaIMG,
    tagKabupatenIMG,
    tagKampungIMG,
    tagDistrikIMG,
    warningMessage,
    timeScheduleVid,
    judulIndonesiaVid,
    captionIndonesiaVid,
    deskripsiIndonesiaVid,
    tagKabupatenVid,
    tagKampungVid,
    tagDistrikVid,
    warningMessageVid,
  ];

  SubmitArticleState copyWith({
    SubmitStateStatus? status,
    File? videoFile,
    XFile? photoFile,
    String? titleArticle,
    String? descriptionArticle,
    bool? hideAuthor,
    File? thumbnailVideo,
    ChewieController? chewieController,
    VideoPlayerController? videoController,
    File? audioFile,
    String? timeSchedule,
    String? judulIndonesiaIMG,
    String? captionIndonesiaIMG,
    String? deskripsiIndonesiaIMG,
    String? tagKabupatenIMG,
    String? tagKampungIMG,
    String? tagDistrikIMG,
    String? warningMessage,
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
    return SubmitArticleState(
        status: status ?? this.status,
        videoFile: videoFile ?? this.videoFile,
        photoFile: photoFile ?? this.photoFile,
        titleArticle: titleArticle ?? this.titleArticle,
        descriptionArticle: descriptionArticle ?? this.descriptionArticle,
        hideAuthor: hideAuthor ?? this.hideAuthor,
        thumbnailVideo: thumbnailVideo ?? this.thumbnailVideo,
        chewieController: chewieController ?? this.chewieController,
        videoController: videoController ?? this.videoController,
        audioFile: audioFile ?? this.audioFile,
        timeSchedule: timeSchedule ?? this.timeSchedule,
        judulIndonesiaIMG: judulIndonesiaIMG ?? this.judulIndonesiaIMG,
        captionIndonesiaIMG: captionIndonesiaIMG ?? this.captionIndonesiaIMG,
        deskripsiIndonesiaIMG: deskripsiIndonesiaIMG ?? this.deskripsiIndonesiaIMG,
        tagKabupatenIMG: tagKabupatenIMG ?? this.tagKabupatenIMG,
        tagKampungIMG: tagKampungIMG ?? this.tagKampungIMG,
        tagDistrikIMG: tagDistrikIMG ?? this.tagDistrikIMG,
        warningMessage: warningMessage ?? this.warningMessage,
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

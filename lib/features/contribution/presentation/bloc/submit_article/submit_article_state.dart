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
  final SubmitStateStatus statusDelete;
  final File? videoFile;
  final XFile? photoFile;
  final XFile? photoFileEdited;
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
  /// FOR EDIT
  final XFile? editPhotoFile;
  final String? editTimeSchedule;
  final String? editJudulIndonesia;
  final String? editCaptionIndonesia;
  final String? editDeskripsiIndonesia;
  final String? editTagKabupaten;
  final String? editTagKampung;
  final String? editTagDistrik;
  final bool? edithideAuthor;

  final String? detailPathUrl;
  final String? detailTimeSchedule;
  final String? detailJudul;
  final String? detailCaption;
  final String? detailDeskripsi;


  const SubmitArticleState({
    this.status = SubmitStateStatus.initial,
    this.statusDelete = SubmitStateStatus.initial,
    this.videoFile,
    this.photoFile,
    this.photoFileEdited,
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
    this.editPhotoFile,
    this.editTimeSchedule,
    this.editJudulIndonesia,
    this.editCaptionIndonesia,
    this.editDeskripsiIndonesia,
    this.editTagKabupaten,
    this.editTagKampung,
    this.editTagDistrik,
    this.edithideAuthor,

    this.detailPathUrl,
    this.detailTimeSchedule,
    this.detailJudul,
    this.detailCaption,
    this.detailDeskripsi,
  });

  @override
  List<Object?> get props => [
    status,
    statusDelete,
    videoFile,
    photoFile,
    photoFileEdited,
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
    editPhotoFile,
    editTimeSchedule,
    editJudulIndonesia,
    editCaptionIndonesia,
    editDeskripsiIndonesia,
    editTagKabupaten,
    editTagKampung,
    editTagDistrik,
    edithideAuthor,

    detailPathUrl,
    detailTimeSchedule,
    detailJudul,
    detailCaption,
    detailDeskripsi,
  ];

  SubmitArticleState copyWith({
    SubmitStateStatus? status,
    SubmitStateStatus? statusDelete,
    File? videoFile,
    XFile? photoFile,
    XFile? photoFileEdited,
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
    String? warningMessageVid,
    /// UNTUK EDIT
     XFile? editPhotoFile,
     String? editTimeSchedule,
     String? editJudulIndonesia,
     String? editCaptionIndonesia,
     String? editDeskripsiIndonesia,
     String? editTagKabupaten,
     String? editTagKampung,
     String? editTagDistrik,
    bool? edithideAuthor,

    String? detailPathUrl,
    String? detailTimeSchedule,
    String? detailJudul,
    String? detailCaption,
    String? detailDeskripsi,
  }) {
    return SubmitArticleState(
        status: status ?? this.status,
        statusDelete: statusDelete ?? this.statusDelete,
        videoFile: videoFile ?? this.videoFile,
        photoFile: photoFile ?? this.photoFile,
        photoFileEdited: photoFileEdited ?? this.photoFileEdited,
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
        editPhotoFile: editPhotoFile ?? this.editPhotoFile,
        editTimeSchedule: editTimeSchedule ?? this.editTimeSchedule,
        editJudulIndonesia: editJudulIndonesia ?? this.editJudulIndonesia,
        editCaptionIndonesia: editCaptionIndonesia ?? this.editCaptionIndonesia,
        editDeskripsiIndonesia: editDeskripsiIndonesia ?? this.editDeskripsiIndonesia,
        editTagKabupaten: editTagKabupaten ?? this.editTagKabupaten,
        editTagKampung: editTagKampung ?? this.editTagKampung,
        editTagDistrik: editTagDistrik ?? this.editTagDistrik,
        edithideAuthor: edithideAuthor ?? this.edithideAuthor,
        detailPathUrl: detailPathUrl ?? this.detailPathUrl,
        detailTimeSchedule: detailTimeSchedule ?? this.detailTimeSchedule,
        detailJudul: detailJudul ?? this.detailJudul,
        detailCaption: detailCaption ?? this.detailCaption,
        detailDeskripsi: detailDeskripsi ?? this.detailDeskripsi,
    );
  }
}

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
  final File? photoFile;
  final String? titleArticle;
  final String? descriptionArticle;
  final bool? hideAuthor;
  final File? thumbnailVideo;
  final VideoPlayerController? videoController;
  final ChewieController? chewieController;
  /// FOR AUDIO RECORDER
  final File? audioFile;

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
    this.audioFile
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
    audioFile
  ];

  SubmitArticleState copyWith({
    SubmitStateStatus? status,
    File? videoFile,
    File? photoFile,
    String? titleArticle,
    String? descriptionArticle,
    bool? hideAuthor,
    File? thumbnailVideo,
    ChewieController? chewieController,
    VideoPlayerController? videoController,
    File? audioFile
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
      audioFile: audioFile ?? this.audioFile
    );
  }
}

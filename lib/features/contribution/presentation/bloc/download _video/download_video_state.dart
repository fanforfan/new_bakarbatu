part of 'download_video_bloc.dart';

enum DownloadStatus { initial, success, error, loading }

extension DownloadStatusX on DownloadStatus {
  bool get isInitial => this == DownloadStatus.initial;
  bool get isSuccess => this == DownloadStatus.success;
  bool get isError => this == DownloadStatus.error;
  bool get isLoading => this == DownloadStatus.loading;
}

class DownloadVideoState extends Equatable {
  final DownloadStatus status;
  final String? fileVideoPath;
  final String? idLoading;
  final String? progress;



  const DownloadVideoState({
    this.status = DownloadStatus.initial,
    this.fileVideoPath,
    this.idLoading,
    this.progress
  });

  @override
  List<Object?> get props => [
    status,
    fileVideoPath,
    idLoading,
    progress,
  ];

  DownloadVideoState copyWith({
    DownloadStatus? status,
    String? fileVideoPath,
    String? idLoading,
    String? progress
  }) {
    return DownloadVideoState(
        status: status ?? this.status,
        fileVideoPath: fileVideoPath ?? this.fileVideoPath,
        idLoading: idLoading ?? this.idLoading,
        progress: progress ?? this.progress
    );
  }
}

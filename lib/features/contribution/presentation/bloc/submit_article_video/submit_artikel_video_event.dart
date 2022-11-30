part of 'submit_artikel_video_bloc.dart';

abstract class SubmitArtikelVideoEvent extends Equatable {
  const SubmitArtikelVideoEvent();
}

class PickVideoFile extends SubmitArtikelVideoEvent {
  final File? videoFile;

  PickVideoFile({this.videoFile});

  @override
  List<Object?> get props => [videoFile];
}

class ChangeHideShowAuthorVid extends SubmitArtikelVideoEvent {
  final bool? value;

  ChangeHideShowAuthorVid({this.value});

  @override
  List<Object?> get props => [value];
}

/// FOR VIDEO
class ChangeTimeScheduleVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeTimeScheduleVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeJudulIndonesiaVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeJudulIndonesiaVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeCaptionIndonesiaVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeCaptionIndonesiaVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeDeskripsiIndonesiaVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeDeskripsiIndonesiaVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeKabutapenVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeKabutapenVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeKampungVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeKampungVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeDistrikVid extends SubmitArtikelVideoEvent {
  final String? value;

  ChangeDistrikVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeHideAuthorVid extends SubmitArtikelVideoEvent {
  final bool? value;

  ChangeHideAuthorVid({this.value});

  @override
  List<Object?> get props => [value];
}

class ClearFormVid extends SubmitArtikelVideoEvent {
  @override
  List<Object?> get props => [];
}

class ValidateToSubmitArticleVid extends SubmitArtikelVideoEvent {
  @override
  List<Object?> get props => [];
}
/// END FOR VIDEO

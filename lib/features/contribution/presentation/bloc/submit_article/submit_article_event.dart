part of 'submit_article_bloc.dart';

abstract class SubmitArticleEvent extends Equatable {}

class PickVideo extends SubmitArticleEvent {
  final File? videoFile;

  PickVideo({this.videoFile});

  @override
  List<Object?> get props => [videoFile];
}

class ChangeTitleArticle extends SubmitArticleEvent {
  final String? value;

  ChangeTitleArticle({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeDescriptionArticle extends SubmitArticleEvent {
  final String? value;

  ChangeDescriptionArticle({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeHideShowAuthor extends SubmitArticleEvent {
  final bool? value;

  ChangeHideShowAuthor({this.value});

  @override
  List<Object?> get props => [value];
}

class SubmitArticleBasic extends SubmitArticleEvent {
  final Article article;

  SubmitArticleBasic({required this.article});

  @override
  // TODO: implement props
  List<Object?> get props => [article];


}

class GetImageArticle extends SubmitArticleEvent {
  final XFile imageFile;

  GetImageArticle({
    required this.imageFile
  });

  @override
  List<Object?> get props => [
    imageFile
  ];
}

class GetImageArticleEdited extends SubmitArticleEvent {
  final XFile imageFile;

  GetImageArticleEdited({
    required this.imageFile
  });

  @override
  List<Object?> get props => [
    imageFile
  ];
}

class PickAudio extends SubmitArticleEvent {
  final File? audioFile;

  PickAudio({this.audioFile});

  @override
  List<Object?> get props => [audioFile];
}
/// FOR IMAGE
class ChangeTimeSchedule extends SubmitArticleEvent {
  final String? value;

  ChangeTimeSchedule({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeJudulIndonesia extends SubmitArticleEvent {
  final String? value;

  ChangeJudulIndonesia({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeCaptionIndonesia extends SubmitArticleEvent {
  final String? value;

  ChangeCaptionIndonesia({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeDeskripsiIndonesia extends SubmitArticleEvent {
  final String? value;

  ChangeDeskripsiIndonesia({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeKabutapen extends SubmitArticleEvent {
  final String? value;

  ChangeKabutapen({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeKampung extends SubmitArticleEvent {
  final String? value;

  ChangeKampung({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeDistrik extends SubmitArticleEvent {
  final String? value;

  ChangeDistrik({this.value});

  @override
  List<Object?> get props => [value];
}

class ChangeHideAuthor extends SubmitArticleEvent {
  final bool? value;

  ChangeHideAuthor({this.value});

  @override
  List<Object?> get props => [value];
}

class ClearFormIMG extends SubmitArticleEvent {
  @override
  List<Object?> get props => [];
}

class ValidateToSubmitArticle extends SubmitArticleEvent {
  @override
  List<Object?> get props => [];
}

class SaveUpdateToLocalArticle extends SubmitArticleEvent {
  final String? collectionKey;
  final String? fileExisting;

  SaveUpdateToLocalArticle({this.collectionKey, this.fileExisting});
  @override
  // TODO: implement props
  List<Object?> get props => [collectionKey, fileExisting];

}

class LocalToServer extends SubmitArticleEvent {
  final ContributionArticle? data;

  LocalToServer({this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];

}
/// END FOR IMAGE




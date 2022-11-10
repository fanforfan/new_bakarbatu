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

  ChangeHideShowAuthor(this.value);

  @override
  List<Object?> get props => [value];
}

class PickFoto extends SubmitArticleEvent {
  @override
  List<Object?> get props => [];
}

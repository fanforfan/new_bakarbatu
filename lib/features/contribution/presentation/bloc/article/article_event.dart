part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent extends Equatable {}

class GetArticle extends ArticleEvent {
  final int statusArticle;

  GetArticle({required this.statusArticle});

  @override
  // TODO: implement props
  List<Object?> get props => [statusArticle];
}

class GetArticleOnline extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

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

class GetNextArticle extends ArticleEvent {
  final int? page;

  GetNextArticle({this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [page];
}

class SearchArticle extends ArticleEvent {
  final String? keySearch;

  SearchArticle({this.keySearch});

  @override
  // TODO: implement props
  List<Object?> get props => [keySearch];
}

class GetArticleOnline extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

part of 'article_category_bloc.dart';

abstract class ArticleCategoryEvent extends Equatable {
  const ArticleCategoryEvent();
}

class GetArticleOnline extends ArticleCategoryEvent {
  final int category;

  const GetArticleOnline({required this.category});
  @override
  // TODO: implement props
  List<Object?> get props => [category];
}

class SearchArticleCategory extends ArticleCategoryEvent {
  final String? keySearch;

  const SearchArticleCategory({this.keySearch});

  @override
  // TODO: implement props
  List<Object?> get props => [keySearch];
}

class GetNextArticle extends ArticleCategoryEvent {
  final int? page;

  const GetNextArticle({this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [page];
}
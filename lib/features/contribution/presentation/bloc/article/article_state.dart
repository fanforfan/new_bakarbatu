part of 'article_bloc.dart';

enum ArticleStatus { initial, success, error, loading }

extension ArticleStatusX on ArticleStatus {
  bool get isInitial => this == ArticleStatus.initial;
  bool get isSuccess => this == ArticleStatus.success;
  bool get isError => this == ArticleStatus.error;
  bool get isLoading => this == ArticleStatus.loading;
}

class ArticleState extends Equatable {
  final ArticleStatus status;
  final String? message;
  final List<ContributionArticle>? article;
  final List<ContributionArticle>? allArticleLocal;
  final List<ContributionArticle>? articleSearchResultLocal;
  final List<DataNewsroom>? allArticleOnline;
  final List<DataNewsroom>? articleOnline;
  final List<DataNewsroom>? articleSearchResult;
  final bool? isSearch;
  final bool? isSearchLocal;
  final int? page;
  final int? pageLocal;


  const ArticleState({
    this.status = ArticleStatus.initial,
    this.message,
    this.article,
    this.allArticleLocal,
    this.articleSearchResultLocal,
    this.allArticleOnline,
    this.articleOnline,
    this.articleSearchResult,
    this.isSearch,
    this.isSearchLocal,
    this.page,
    this.pageLocal
  });

  @override
  List<Object?> get props => [
    status,
    message,
    article,
    allArticleLocal,
    articleSearchResultLocal,
    allArticleOnline,
    articleOnline,
    articleSearchResult,
    isSearch,
    isSearchLocal,
    page,
    pageLocal
  ];

  ArticleState copyWith({
    ArticleStatus? status,
    String? message,
    List<ContributionArticle>? article,
    List<ContributionArticle>? allArticleLocal,
    List<ContributionArticle>? articleSearchResultLocal,
    List<DataNewsroom>? allArticleOnline,
    List<DataNewsroom>? articleOnline,
    List<DataNewsroom>? articleSearchResult,
    bool? isSearch,
    bool? isSearchLocal,
    int? page,
    int? pageLocal
  }) {
    return ArticleState(
        status: status ?? this.status,
        message: message ?? this.message,
        article: article ?? this.article,
        allArticleLocal: allArticleLocal ?? this.allArticleLocal,
        articleSearchResultLocal: articleSearchResultLocal ?? this.articleSearchResultLocal,
        allArticleOnline: allArticleOnline ?? this.allArticleOnline,
        articleOnline: articleOnline ?? this.articleOnline,
        articleSearchResult: articleSearchResult ?? this.articleSearchResult,
        isSearch: isSearch ?? this.isSearch,
        isSearchLocal: isSearchLocal ?? this.isSearchLocal,
        page: page ?? this.page,
        pageLocal: pageLocal ?? this.pageLocal
    );
  }
}

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
  final List<DataNewsroom>? allArticleOnline;
  final List<DataNewsroom>? articleOnline;
  final List<DataNewsroom>? articleSearchResult;
  final bool? isSearch;
  final int? page;


  const ArticleState({
    this.status = ArticleStatus.initial,
    this.message,
    this.article,
    this.allArticleOnline,
    this.articleOnline,
    this.articleSearchResult,
    this.isSearch,
    this.page
  });

  @override
  List<Object?> get props => [
    status,
    message,
    article,
    allArticleOnline,
    articleOnline,
    articleSearchResult,
    isSearch,
    page
  ];

  ArticleState copyWith({
    ArticleStatus? status,
    String? message,
    List<ContributionArticle>? article,
    List<DataNewsroom>? allArticleOnline,
    List<DataNewsroom>? articleOnline,
    List<DataNewsroom>? articleSearchResult,
    bool? isSearch,
    int? page
  }) {
    return ArticleState(
        status: status ?? this.status,
        message: message ?? this.message,
        article: article ?? this.article,
        allArticleOnline: allArticleOnline ?? this.allArticleOnline,
        articleOnline: articleOnline ?? this.articleOnline,
        articleSearchResult: articleSearchResult ?? this.articleSearchResult,
        isSearch: isSearch ?? this.isSearch,
        page: page ?? this.page
    );
  }
}

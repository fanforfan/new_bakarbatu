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


  const ArticleState({
    this.status = ArticleStatus.initial,
    this.message,
    this.article
  });

  @override
  List<Object?> get props => [
    status,
    message,
    article
  ];

  ArticleState copyWith({
    ArticleStatus? status,
    String? message,
    List<ContributionArticle>? article
  }) {
    return ArticleState(
        status: status ?? this.status,
        message: message ?? this.message,
        article: article ?? this.article
    );
  }
}

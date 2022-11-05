part of 'home_bloc.dart';

enum HomeStateStatus { initial, success, error, loading }

extension AuthStateStatusX on HomeStateStatus {
  bool get isInitial => this == HomeStateStatus.initial;
  bool get isSuccess => this == HomeStateStatus.success;
  bool get isError => this == HomeStateStatus.error;
  bool get isLoading => this == HomeStateStatus.loading;
}

class HomeState extends Equatable {
  final Uri? urlWebview;
  final HomeStateStatus status;
  final String? message;

  const HomeState({
    this.urlWebview,
    this.status = HomeStateStatus.initial,
    this.message
  });

  @override
  List<Object?> get props => [
    urlWebview,
    status,
    message
  ];

  HomeState copyWith({
    Uri? urlWebview,
    HomeStateStatus? status,
    String? message
  }) {
    return HomeState(
        urlWebview: urlWebview ?? this.urlWebview,
        status: status ?? this.status,
        message: message ?? this.message
    );
  }
}

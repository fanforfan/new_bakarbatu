part of 'authentication_bloc.dart';

enum AuthenticationStateStatus { initial, success, error, loading }

extension AuthStateStatusX on AuthenticationStateStatus {
  bool get isInitial => this == AuthenticationStateStatus.initial;
  bool get isSuccess => this == AuthenticationStateStatus.success;
  bool get isError => this == AuthenticationStateStatus.error;
  bool get isLoading => this == AuthenticationStateStatus.loading;
}

class AuthenticationState extends Equatable {
  final String? username;
  final String? password;
  final AuthenticationStateStatus status;
  final String? message;
  final bool? logoutSuccess;
  final bool? isLogin;

  const AuthenticationState({
    this.username,
    this.password,
    this.status = AuthenticationStateStatus.initial,
    this.message,
    this.logoutSuccess,
    this.isLogin
  });

  @override
  List<Object?> get props => [
    username,
    password,
    status,
    message,
    logoutSuccess,
    isLogin
  ];

  AuthenticationState copyWith({
    String? username,
    String? password,
    AuthenticationStateStatus? status,
    String? message,
    bool? logoutSuccess,
    bool? isLogin
  }) {
    return AuthenticationState(
        username: username ?? this.username ,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message,
        logoutSuccess: logoutSuccess ?? this.logoutSuccess,
        isLogin: isLogin ?? this.isLogin
    );
  }
}

import 'package:equatable/equatable.dart';

class AuthenticationDataEntity extends Equatable {
  final String? username;
  final String? password;
  final String? fullname;
  final bool error;
  final String? message;

  const AuthenticationDataEntity({
    this.username,
    this.password,
    this.fullname,
    this.error = false,
    this.message
  });

  @override
  List<Object?> get props => [
    username,
    password,
    fullname,
    error,
    message
  ];
}
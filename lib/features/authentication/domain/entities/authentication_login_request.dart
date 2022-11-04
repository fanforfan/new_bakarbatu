import 'package:equatable/equatable.dart';

class AuthenticationLoginRequest extends Equatable {
  final String username;
  final String password;

  const AuthenticationLoginRequest({required this.username, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}
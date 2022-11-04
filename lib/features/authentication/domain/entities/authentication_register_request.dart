import 'package:equatable/equatable.dart';

class AuthenticationregisterRequest extends Equatable {
  final String username;
  final String password;
  final String fullName;

  const AuthenticationregisterRequest({required this.username, required this.password, required this.fullName});

  @override
  // TODO: implement props
  List<Object?> get props => [username, password, fullName];
}
part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  AuthLoginEvent({
    required this.username, 
    required this.password});

  @override
  List<Object> get props => [
    username,
    password
  ];
}

class AuthRegisterEvent extends AuthenticationEvent {
  final String username;
  final String password;
  final String fullname;

  AuthRegisterEvent({
    required this.username, 
    required this.password, 
    required this.fullname});

  @override
  List<Object> get props => [
    username,
    password,
    fullname
  ];
}

class TextFieldChanged extends AuthenticationEvent {
  final String keyField;
  final String value;

  TextFieldChanged({required this.keyField, required this.value});

  @override
  List<Object> get props => [
    keyField, 
    value
  ];
}

class AuthLogout extends AuthenticationEvent {}

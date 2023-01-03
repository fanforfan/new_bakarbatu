part of 'email_cubit.dart';

class EmailState {}

class ValidateEmail extends EmailState {
  final String message;

  ValidateEmail({
    required this.message
  });
}

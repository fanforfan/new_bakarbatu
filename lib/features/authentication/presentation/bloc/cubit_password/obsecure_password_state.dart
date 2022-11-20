part of 'obsecure_password_cubit.dart';

class ObsecurePasswordState {}

class ChangeObsecureStatus extends ObsecurePasswordState {
  final bool isObsecure;

  ChangeObsecureStatus({
    required this.isObsecure
  });
}

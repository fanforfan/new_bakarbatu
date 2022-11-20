import 'package:flutter_bloc/flutter_bloc.dart';
part 'obsecure_password_state.dart';

class ObsecurePasswordCubit extends Cubit<ObsecurePasswordState> {
  ObsecurePasswordCubit() : super(ObsecurePasswordState());

  void changeObsecurePassword({required bool val}){
    emit(ChangeObsecureStatus(isObsecure: !val));
  }
}

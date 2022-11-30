import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/usecases/authentication_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecase authenticationUsecase;

  AuthenticationBloc({required this.authenticationUsecase}) : super(const AuthenticationState()) {
    on<AuthLoginEvent>(_validateLogin);
    on<TextFieldChanged>(_textFieldChanged);
    on<AuthLogout>(_validateLogout);
  }

  _validateLogin(AuthLoginEvent event, Emitter<AuthenticationState> emit) async {
    // Set state status to loading

    var loginRequest = AuthenticationLoginRequest(
      username: event.username,
      password: event.password
    );

    try{
      emit(state.copyWith(
        status: AuthenticationStateStatus.loading
      ));
      var response = await authenticationUsecase.validateLogin(loginRequest);
      if(response != null){
        emit(state.copyWith(
          message: response.message,
          status: AuthenticationStateStatus.success,
        ));
        // Set value state to default
        if(state.message == 'Login Berhasil'){
          emit(state.copyWith(
            message: '',
            status: AuthenticationStateStatus.initial,
            username: '',
            password: ''
          ));
        }
      }
    } catch(error) {
      emit(
        state.copyWith(
          message: '$error',
          status: AuthenticationStateStatus.error
        )
      );
    }
  }

  _textFieldChanged(TextFieldChanged event, Emitter<AuthenticationState> emit) {
    if(event.keyField == 'Username'){
      emit(state.copyWith(
        username: event.value
      ));
    }else if(event.keyField == 'Password'){
      emit(state.copyWith(
        password: event.value
      ));
    }
  }

  _validateLogout(AuthLogout event, Emitter<AuthenticationState> emit) async {
    try{
      emit(state.copyWith(
          status: AuthenticationStateStatus.loading
      ));
      var response = await authenticationUsecase.authLogout();
      print('HALOO NJENG : $response');
      emit(state.copyWith(
        status: AuthenticationStateStatus.success,
        logoutSuccess: response
      ));
    } catch(error) {
      emit(
          state.copyWith(
              message: '$error',
              status: AuthenticationStateStatus.error
          )
      );
    }
  }
}



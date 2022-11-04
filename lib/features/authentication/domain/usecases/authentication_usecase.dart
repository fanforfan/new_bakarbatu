import 'package:new_bakarbatu/core/usecases/usecase.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_register_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationUsecase implements Usecase {
  final AuthenticationRepository repository;

  AuthenticationUsecase(this.repository);

  @override
  Future<AuthenticationDataEntity?> validateLogin(
      AuthenticationLoginRequest paramLogin
      ) async {
    return await repository.validateLogin(paramLogin);
  }

  @override
  Future<AuthenticationDataEntity?> validateRegister(
      AuthenticationregisterRequest paramsRegister
      ) async {
    return await repository.validateRegister(paramsRegister);
  }
}
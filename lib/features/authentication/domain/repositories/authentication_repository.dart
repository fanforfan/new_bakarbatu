import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_register_request.dart';

abstract class AuthenticationRepository {

  Future<AuthenticationDataEntity?> validateLogin(AuthenticationLoginRequest paramLogin);

  Future<AuthenticationDataEntity?> validateRegister(AuthenticationregisterRequest paramsRegister);
  
}
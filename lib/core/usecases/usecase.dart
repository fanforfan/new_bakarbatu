import 'package:dartz/dartz.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_register_request.dart';
import '../error/failure.dart';

abstract class Usecase {
  Future<AuthenticationDataEntity?> validateLogin(AuthenticationLoginRequest loginParams);
  Future<AuthenticationDataEntity?> validateRegister(AuthenticationregisterRequest registerParams);
}
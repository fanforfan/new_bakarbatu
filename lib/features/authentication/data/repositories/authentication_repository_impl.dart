import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/core/network/network_info.dart';
import 'package:new_bakarbatu/features/authentication/data/datasources/authentication_local_datasources.dart';
import 'package:new_bakarbatu/features/authentication/data/datasources/authentication_remote_datasources.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_register_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:new_bakarbatu/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasources remoteDatasource;
  final AuthenticationLocalDatasources localDatasource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDatasource, 
    required this.localDatasource, 
    required this.networkInfo});

  @override
  Future<AuthenticationDataEntity?> validateLogin(AuthenticationLoginRequest paramLogin) async {
    // TODO: implement validateLogin
    // print('KESININ ${paramLogin.username} - ${paramLogin.password}');
    // return null;
    // if(await networkInfo.isConnected){
    //   print('KESININ 1');
      try{
        final remoteValidateLogin = await remoteDatasource.validateLogin(paramLogin);
        return remoteValidateLogin;
      } on ServerException {
        return const AuthenticationDataEntity(
          error: true
        );
      }
    // }else{
    //   print('KESININ 2');
    //   try{
    //     final lastLogin = await localDatasource.getLastLogin();
    //     return lastLogin;
    //   } on LocalException {
    //     return null;
    //   }
    // }
  }

  @override
  Future<AuthenticationDataEntity?> validateRegister(AuthenticationregisterRequest paramsRegister) async {
    // TODO: implement validateRegister
    try{
      final remoteValidateRegister = await remoteDatasource.validateRegister(paramsRegister);
      return remoteValidateRegister;
    } on ServerException {
      return null;
    }
  }

}
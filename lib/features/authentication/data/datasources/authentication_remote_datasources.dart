import 'dart:convert';

import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/features/authentication/data/models/auth_login_model.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/authentication_login_request.dart';
import '../../domain/entities/authentication_register_request.dart';

abstract class AuthenticationRemoteDatasources {
  Future<AuthenticationDataEntity>? validateRegister(AuthenticationregisterRequest paramsRegister);

  Future<AuthenticationDataEntity>? validateLogin(AuthenticationLoginRequest paramLogin);
}

class AuthenticationRemoteDatasourcesImpl implements AuthenticationRemoteDatasources {
  final http.Client client;

  AuthenticationRemoteDatasourcesImpl({required this.client});

  @override
  Future<AuthenticationDataEntity>? validateLogin(AuthenticationLoginRequest paramLogin) async {

    var response = {
      'username' : 'fandis',
      'password' : 'test',
      'full_name' : 'Fandi Sujatmiko'
    };

    if(response['username'] != paramLogin.username){
      return const AuthenticationDataEntity(
        message: 'Username salah',
        error: true
      );
    }else if(response['password'] != paramLogin.password){
      return const AuthenticationDataEntity(
        message: 'Password salah',
        error: true
      );
    }else{
      return AuthenticationDataEntity(
        username: response['username'],
        password: response['password'],
        fullname: response['full_name'],
        error: false,
        message: 'Success'
      );
    }

    // TODO: implement validateLogin
    // final response = await client.post(
    //   Uri.parse('http://url_login.com'), 
    //   body: paramLogin
    // );

    // if(response.statusCode == 200){
    //   return AuthLoginModel.fromJson(json.decode(response.body));
    // }else{
    //   throw ServerException();
    // }
  }

  @override
  Future<AuthenticationDataEntity>? validateRegister(AuthenticationregisterRequest paramsRegister) async {
    // TODO: implement validateRegister
    final response = await client.post(
      Uri.parse('http://url_register.com'), 
      body: paramsRegister
    );

    if(response.statusCode == 200){
      return AuthLoginModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }

}
import 'dart:convert';

import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/features/authentication/data/models/login/LoginResponse.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/authentication_login_request.dart';
import '../../domain/entities/authentication_register_request.dart';

abstract class AuthenticationRemoteDatasources {
  Future<LoginResponse>? validateLogin(AuthenticationLoginRequest paramLogin);

  Future<LoginResponse>? validateRegister(AuthenticationregisterRequest paramsRegister);

  Future<bool?> authLogout(String? string);
}

class AuthenticationRemoteDatasourcesImpl implements AuthenticationRemoteDatasources {
  final http.Client client;

  AuthenticationRemoteDatasourcesImpl({required this.client});

  @override
  Future<LoginResponse>? validateLogin(AuthenticationLoginRequest paramLogin) async {
    var headers = {
      'Accept': 'application/json'
    };

    final request = await client.post(
      Uri.parse('http://api.bakarbatu.id/api/login'),
      headers: headers,
      body: {
        'email':  paramLogin.username,
        'password': paramLogin.password
      }
    );

    var response = LoginResponse.fromJson(json.decode(request.body));

    print('RESPONSE : ${request.body} ${response.message}');

    return response;
  }

  @override
  Future<LoginResponse>? validateRegister(AuthenticationregisterRequest paramsRegister) async {
    // TODO: implement validateRegister
    final response = await client.post(
      Uri.parse('http://url_register.com'), 
      body: paramsRegister
    );

    if(response.statusCode == 200){
      return LoginResponse.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<bool?> authLogout(String? token) async {
    // TODO: implement authLogout
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final request = await client.post(
        Uri.parse('http://api.bakarbatu.id/api/logout'),
        headers: headers
    );

    var response = LoginResponse.fromJson(json.decode(request.body));
    if(response.message == 'Logged out'){
      return true;
    }else{
      return false;
    }
  }

}
import 'dart:convert';

import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/features/authentication/data/models/auth_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDatasources {
  Future<AuthLoginModel> getLastLogin();
  Future<void> cacheAuthLogin(AuthLoginModel authLoginModel);
}

class AuthenticationLocalDatasourcesImpl implements AuthenticationLocalDatasources {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDatasourcesImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAuthLogin(AuthLoginModel authLoginModel) {
    // TODO: implement cacheAuthLogin
    throw UnimplementedError();
  }

  @override
  Future<AuthLoginModel> getLastLogin() {
    // TODO: implement getLastLogin
    final jsonString = sharedPreferences.getString('CACHE_LOGIN');
    if(jsonString != null){
      return Future.value(AuthLoginModel.fromJson(json.decode(jsonString)));
    } else {
      throw LocalException();
    }
  }

} 
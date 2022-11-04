import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';

class AuthLoginModel extends AuthenticationDataEntity {
  const AuthLoginModel({
    String? username,
    String? password,
    String? fullname
  }) : super(
    username: username, 
    password: password, 
    fullname: fullname);

  factory AuthLoginModel.fromJson(Map<String, dynamic> json){
    return AuthLoginModel(
      username: json['username'], 
      password: json['password'], 
      fullname: json['fullname']);
  }

  Map<String, dynamic> toJson(){
    return {
          "username" : username,
          "password" : password,
          "fullname" : fullname
        };
  }
}
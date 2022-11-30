import '../../domain/entities/authentication.dart';

class AuthLoginModel {
  AuthenticationDataEntity? dataUser;
  String? token;
  String? message;
  String? rc;

  AuthLoginModel({this.dataUser, this.token, this.message, this.rc});

  AuthLoginModel.fromJson(Map<String, dynamic> json) {
    dataUser = json['data_user'] != null
        ? AuthenticationDataEntity.fromJson(json['data_user'])
        : null;
    token = json['token'];
    message = json['message'];
    rc = json['rc'];
  }
}
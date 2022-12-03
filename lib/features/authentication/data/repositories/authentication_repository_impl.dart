import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/core/network/network_info.dart';
import 'package:new_bakarbatu/features/authentication/data/datasources/authentication_local_datasources.dart';
import 'package:new_bakarbatu/features/authentication/data/datasources/authentication_remote_datasources.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_register_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication_login_request.dart';
import 'package:new_bakarbatu/features/authentication/domain/entities/authentication.dart';
import 'package:new_bakarbatu/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      try{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final remoteValidateLogin = await remoteDatasource.validateLogin(paramLogin);
        var data = AuthenticationDataEntity(
            message: remoteValidateLogin?.message,
            id: remoteValidateLogin?.dataUser?.id,
            username: remoteValidateLogin?.dataUser?.username,
            email: remoteValidateLogin?.dataUser?.email,
            photo: remoteValidateLogin?.dataUser?.photo,
            phone: remoteValidateLogin?.dataUser?.phone,
            ttl: remoteValidateLogin?.dataUser?.ttl,
            gender: remoteValidateLogin?.dataUser?.gender,
            provinsi: remoteValidateLogin?.dataUser?.provinsi,
            kabupaten: remoteValidateLogin?.dataUser?.kabupaten,
            kecamatan: remoteValidateLogin?.dataUser?.kecamatan,
            kelurahan: remoteValidateLogin?.dataUser?.kelurahan,
            alamat: remoteValidateLogin?.dataUser?.alamat,
            savedDate: remoteValidateLogin?.dataUser?.savedDate,
            userRegisterBy: remoteValidateLogin?.dataUser?.userRegisterBy,
            status: remoteValidateLogin?.dataUser?.status,
            lastLogin: remoteValidateLogin?.dataUser?.lastLogin,
            komunitasId: remoteValidateLogin?.dataUser?.komunitasId,
            nameKomunitas: remoteValidateLogin?.dataUser?.nameKomunitas,
            token: remoteValidateLogin?.token
        );

        prefs.setInt(KeyPreferenches.idUser, data.id!);
        prefs.setString(KeyPreferenches.username, data.username!);
        prefs.setString(KeyPreferenches.email, data.email!);
        prefs.setString(KeyPreferenches.phone, data.phone!);
        prefs.setString(KeyPreferenches.ttl, data.ttl!);
        prefs.setString(KeyPreferenches.gender, data.gender!);
        prefs.setString(KeyPreferenches.provinsi, data.provinsi!);
        prefs.setString(KeyPreferenches.kabupaten, data.kabupaten!);
        prefs.setString(KeyPreferenches.kecamatan, data.kecamatan!);
        prefs.setString(KeyPreferenches.kelurahan, data.kelurahan!);
        prefs.setString(KeyPreferenches.alamat, data.alamat!);
        prefs.setString(KeyPreferenches.savedData, data.savedDate!);
        prefs.setInt(KeyPreferenches.userRergisterBy, data.userRegisterBy!);
        prefs.setInt(KeyPreferenches.status, data.status!);
        prefs.setString(KeyPreferenches.lastLogin, data.lastLogin!);
        prefs.setInt(KeyPreferenches.komunitasId, data.komunitasId!);
        prefs.setString(KeyPreferenches.nameKomunitas, data.nameKomunitas!);
        prefs.setString(KeyPreferenches.token, data.token!);
        prefs.setBool(KeyPreferenches.isLogin, true);

        return data;
      } on ServerException {
        return null;
      }
  }

  @override
  Future<AuthenticationDataEntity?> validateRegister(AuthenticationregisterRequest paramsRegister) async {
    // TODO: implement validateRegister
    try{
      final remoteValidateRegister = await remoteDatasource.validateRegister(paramsRegister);
      var data = AuthenticationDataEntity(
          id: remoteValidateRegister?.dataUser?.id,
          username: remoteValidateRegister?.dataUser?.username,
          email: remoteValidateRegister?.dataUser?.email,
          photo: remoteValidateRegister?.dataUser?.photo,
          phone: remoteValidateRegister?.dataUser?.phone,
          ttl: remoteValidateRegister?.dataUser?.ttl,
          gender: remoteValidateRegister?.dataUser?.gender,
          provinsi: remoteValidateRegister?.dataUser?.provinsi,
          kabupaten: remoteValidateRegister?.dataUser?.kabupaten,
          kecamatan: remoteValidateRegister?.dataUser?.kecamatan,
          kelurahan: remoteValidateRegister?.dataUser?.kelurahan,
          alamat: remoteValidateRegister?.dataUser?.alamat,
          savedDate: remoteValidateRegister?.dataUser?.savedDate,
          userRegisterBy: remoteValidateRegister?.dataUser?.userRegisterBy,
          status: remoteValidateRegister?.dataUser?.status,
          lastLogin: remoteValidateRegister?.dataUser?.lastLogin,
          komunitasId: remoteValidateRegister?.dataUser?.komunitasId,
          nameKomunitas: remoteValidateRegister?.dataUser?.nameKomunitas
      );
      return data;
    } on ServerException {
      return null;
    }
  }

  @override
  Future<bool?> authLogout() async {
    // TODO: implement authLogout
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final logout = await remoteDatasource.authLogout(prefs.getString('token'));
    if(logout != null){
      if(logout){
        await prefs.clear();
      }
    }
    return logout;
  }

}
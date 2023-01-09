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

        if(remoteValidateLogin != null){
          if(remoteValidateLogin.rc != '0500'){
            if(remoteValidateLogin.dataError != null){
              var data = AuthenticationDataEntity(
                  message: remoteValidateLogin.dataError?.errorEmail,
                  responseCode: '0555'
              );

              return data;
            }else{
              var data = AuthenticationDataEntity(
                  message: remoteValidateLogin.message ?? '-',
                  id: remoteValidateLogin.dataUser?.id,
                  username: remoteValidateLogin.dataUser?.username ?? '-',
                  email: remoteValidateLogin.dataUser?.email ?? '-',
                  photo: remoteValidateLogin.dataUser?.photo ?? '-',
                  phone: remoteValidateLogin.dataUser?.phone ?? '-',
                  ttl: remoteValidateLogin.dataUser?.ttl ?? '-',
                  gender: remoteValidateLogin.dataUser?.gender ?? '-',
                  provinsi: remoteValidateLogin.dataUser?.provinsi ?? '-',
                  kabupaten: remoteValidateLogin.dataUser?.kabupaten ?? '-',
                  kecamatan: remoteValidateLogin.dataUser?.kecamatan ?? '-',
                  kelurahan: remoteValidateLogin.dataUser?.kelurahan ?? '-',
                  alamat: remoteValidateLogin.dataUser?.alamat ?? '-',
                  savedDate: remoteValidateLogin.dataUser?.savedDate ?? '-',
                  userRegisterBy: remoteValidateLogin.dataUser?.userRegisterBy,
                  status: remoteValidateLogin.dataUser?.status,
                  lastLogin: remoteValidateLogin.dataUser?.lastLogin ?? '-',
                  komunitasId: remoteValidateLogin.dataUser?.komunitasId,
                  nameKomunitas: remoteValidateLogin.dataUser?.nameKomunitas ?? '-',
                  token: remoteValidateLogin.token
              );
              await prefs.setInt(KeyPreferenches.idUser, data.id!);
              await prefs.setString(KeyPreferenches.username, data.username!);
              await prefs.setString(KeyPreferenches.email, data.email!);
              await prefs.setString(KeyPreferenches.phone, data.phone!);
              await prefs.setString(KeyPreferenches.ttl, data.ttl!);
              await prefs.setString(KeyPreferenches.gender, data.gender!);
              await prefs.setString(KeyPreferenches.provinsi, data.provinsi!);
              await prefs.setString(KeyPreferenches.kabupaten, data.kabupaten!);
              await prefs.setString(KeyPreferenches.kecamatan, data.kecamatan!);
              await prefs.setString(KeyPreferenches.kelurahan, data.kelurahan!);
              await prefs.setString(KeyPreferenches.alamat, data.alamat!);
              await prefs.setString(KeyPreferenches.savedData, data.savedDate!);
              await prefs.setInt(KeyPreferenches.userRergisterBy, data.userRegisterBy!);
              await prefs.setInt(KeyPreferenches.status, data.status!);
              await prefs.setString(KeyPreferenches.lastLogin, data.lastLogin!);
              await prefs.setInt(KeyPreferenches.komunitasId, data.komunitasId!);
              await prefs.setString(KeyPreferenches.nameKomunitas, data.nameKomunitas!);
              await prefs.setString(KeyPreferenches.token, data.token!);
              await prefs.setBool(KeyPreferenches.isLogin, true);

              return data;
            }

          }else{
            var data = AuthenticationDataEntity(
              message: 'Your password is incorrect.',
              responseCode: remoteValidateLogin.rc
            );

            return data;
          }
        }
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
        print('INI LOGOUT : ${prefs.getInt(KeyPreferenches.idUser)}');
        await prefs.remove(KeyPreferenches.idUser);
        await prefs.remove(KeyPreferenches.username);
        await prefs.remove(KeyPreferenches.email);
        await prefs.remove(KeyPreferenches.phone);
        await prefs.remove(KeyPreferenches.ttl);
        await prefs.remove(KeyPreferenches.gender);
        await prefs.remove(KeyPreferenches.provinsi);
        await prefs.remove(KeyPreferenches.kabupaten);
        await prefs.remove(KeyPreferenches.kecamatan);
        await prefs.remove(KeyPreferenches.kelurahan);
        await prefs.remove(KeyPreferenches.alamat);
        await prefs.remove(KeyPreferenches.savedData);
        await prefs.remove(KeyPreferenches.userRergisterBy);
        await prefs.remove(KeyPreferenches.status);
        await prefs.remove(KeyPreferenches.lastLogin);
        await prefs.remove(KeyPreferenches.komunitasId);
        await prefs.remove(KeyPreferenches.nameKomunitas);
        await prefs.remove(KeyPreferenches.token);
        await prefs.remove(KeyPreferenches.isLogin);
        await prefs.clear();
        print('INI LOGOUT : ${prefs.getInt(KeyPreferenches.idUser)}');
      }
    }
    return logout;
  }

}
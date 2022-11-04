import 'package:new_bakarbatu/core/error/exceptions.dart';
import 'package:new_bakarbatu/core/network/network_info.dart';
import 'package:new_bakarbatu/features/home/data/datasources/home_remote_datasources.dart';
import 'package:new_bakarbatu/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasources remoteDatasource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo});

  @override
  Future goToWebView(String? urlWebView) async {
    // TODO: implement validateRegister
    try{
      final remoteValidateRegister = await remoteDatasource.goToWebView(urlWebView);
      return remoteValidateRegister;
    } on ServerException {
      return null;
    }
  }

}
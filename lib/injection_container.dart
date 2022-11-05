import 'package:get_it/get_it.dart';
import 'package:new_bakarbatu/core/network/network_info.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/authentication/data/datasources/authentication_remote_datasources.dart';
import 'package:new_bakarbatu/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:new_bakarbatu/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:new_bakarbatu/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/home/data/datasources/home_remote_datasources.dart';
import 'package:new_bakarbatu/features/home/data/repositories/home_repository_impl.dart';
import 'package:new_bakarbatu/features/home/domain/repositories/home_repository.dart';
import 'package:new_bakarbatu/features/home/domain/usecases/home_usecase.dart';
import 'package:new_bakarbatu/features/home/presentation/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/authentication/data/datasources/authentication_local_datasources.dart';

final sl = GetIt.instance;

Future<void> init() async {
//  ! features - Home
  sl.registerFactory(() => HomeBloc(
    homeUsecase: sl(),
  ));
//  ! features - Authentication
  sl.registerFactory(() => AuthenticationBloc(
    authenticationUsecase: sl()
  ));

//  ! Use cases
  sl.registerLazySingleton(() => AuthenticationUsecase(sl()));
  sl.registerLazySingleton(() => HomeUsecase(sl()));

//  ! Repository
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(
    remoteDatasource: sl(),
    localDatasource: sl(),
    networkInfo: sl()
  ));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
    remoteDatasource: sl(), 
    networkInfo: sl()
  ));

//  ! Data sources
  sl.registerLazySingleton<AuthenticationRemoteDatasources>(() => AuthenticationRemoteDatasourcesImpl(client: sl()));
  sl.registerLazySingleton<AuthenticationLocalDatasources>(() => AuthenticationLocalDatasourcesImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<HomeRemoteDatasources>(() => HomeRemoteDatasourcesImpl(client: sl()));

//  ! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

//  ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Routes());

}
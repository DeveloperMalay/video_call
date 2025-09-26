import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/api_constants.dart';
import 'core/network/network_info.dart';
import 'core/services/auth_storage_service.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/models/auth_model.dart';
import 'data/models/user_model.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/users_repository_impl.dart';
import 'data/repositories/video_call_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/users_repository.dart';
import 'domain/repositories/video_call_repository.dart';
import 'domain/usecases/get_cached_users.dart';
import 'domain/usecases/get_users.dart';
import 'domain/usecases/join_meeting.dart';
import 'domain/usecases/login_user.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AuthModelAdapter());

  // Hive boxes
  final usersBox = await Hive.openBox<UserModel>('users_box');
  final authBox = await Hive.openBox<AuthModel>('auth_box');

  // External dependencies
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
    receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
  )));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AuthStorageService>(() => AuthStorageService());

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
    usersBox: usersBox,
    authBox: authBox,
  ));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));
  sl.registerLazySingleton<VideoCallRepository>(() => VideoCallRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => GetCachedUsers(sl()));
  sl.registerLazySingleton(() => JoinMeeting(sl()));
}
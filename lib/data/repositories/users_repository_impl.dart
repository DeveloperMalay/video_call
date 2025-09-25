import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getUsers(page);
        await localDataSource.cacheUsers(remoteUsers.data);
        return Right(remoteUsers.data.map((user) => user.toDomain()).toList());
      } on ServerException {
        return Left(ServerFailure());
      } on NetworkException {
        return Left(NetworkFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try {
        final localUsers = await localDataSource.getCachedUsers();
        return Right(localUsers.map((user) => user.toDomain()).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<User>>> getCachedUsers() async {
    try {
      final localUsers = await localDataSource.getCachedUsers();
      return Right(localUsers.map((user) => user.toDomain()).toList());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
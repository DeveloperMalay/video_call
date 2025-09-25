import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> login(String email, String password);
  Future<Either<Failure, Auth?>> getCachedAuth();
  Future<Either<Failure, void>> logout();
}
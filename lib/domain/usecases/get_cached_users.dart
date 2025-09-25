import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/users_repository.dart';
import 'usecase.dart';

class GetCachedUsers implements UseCase<List<User>, NoParams> {
  final UsersRepository repository;

  GetCachedUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getCachedUsers();
  }
}
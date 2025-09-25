import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_cached_users.dart';
import '../../../domain/usecases/get_users.dart';
import '../../../domain/usecases/usecase.dart';

part 'users_state.dart';
part 'users_cubit.freezed.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsers _getUsers;
  final GetCachedUsers _getCachedUsers;

  UsersCubit({
    required GetUsers getUsers,
    required GetCachedUsers getCachedUsers,
  })  : _getUsers = getUsers,
        _getCachedUsers = getCachedUsers,
        super(const UsersState.initial());

  Future<void> loadUsers({int page = 1}) async {
    emit(const UsersState.loading());

    final failureOrUsers = await _getUsers(GetUsersParams(page: page));

    failureOrUsers.fold(
      (failure) => _loadCachedUsers(),
      (users) => emit(UsersState.loaded(users)),
    );
  }

  Future<void> _loadCachedUsers() async {
    final failureOrCachedUsers = await _getCachedUsers(NoParams());
    
    failureOrCachedUsers.fold(
      (failure) => emit(const UsersState.error('Failed to load users')),
      (users) => users.isEmpty 
        ? emit(const UsersState.error('No users available'))
        : emit(UsersState.loaded(users)),
    );
  }

  Future<void> loadCachedUsers() async {
    emit(const UsersState.loading());
    await _loadCachedUsers();
  }
}
import 'package:hive/hive.dart';
import '../../core/error/exceptions.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

abstract class LocalDataSource {
  Future<void> cacheUsers(List<UserModel> users);
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheAuth(AuthModel auth);
  Future<AuthModel?> getCachedAuth();
  Future<void> clearAuth();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box<UserModel> usersBox;
  final Box<AuthModel> authBox;

  LocalDataSourceImpl({
    required this.usersBox,
    required this.authBox,
  });

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      await usersBox.clear();
      for (int i = 0; i < users.length; i++) {
        await usersBox.put(i, users[i]);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<UserModel>> getCachedUsers() async {
    try {
      return usersBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAuth(AuthModel auth) async {
    try {
      await authBox.put('auth', auth);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<AuthModel?> getCachedAuth() async {
    try {
      return authBox.get('auth');
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearAuth() async {
    try {
      await authBox.delete('auth');
    } catch (e) {
      throw CacheException();
    }
  }
}
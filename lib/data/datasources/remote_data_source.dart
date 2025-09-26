import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/auth_model.dart';
import '../models/users_response_model.dart';

abstract class RemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<UsersResponseModel> getUsers(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl(this.dio);

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      // Accept any valid email and password combination
      if (email.contains('@') && password.isNotEmpty) {
        // Simulate network delay for realistic experience
        await Future.delayed(const Duration(seconds: 1));
        
        // Generate a unique token based on email
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final token = 'token_${email.hashCode}_$timestamp';
        
        // Return auth response for any valid email/password
        return AuthModel(
          token: token,
          email: email,
        );
      } else {
        // Invalid email format or empty password
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UsersResponseModel> getUsers(int page) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return UsersResponseModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
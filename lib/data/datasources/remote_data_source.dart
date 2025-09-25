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
      // Handle dummy credentials for demo purposes
      if (email == 'test@gmail.com' && password == 'test@1234') {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        
        // Return dummy auth response
        return const AuthModel(
          token: 'dummy_token_123456',
          email: 'test@gmail.com',
        );
      }
      
      // For other credentials, try ReqRes API
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/services/auth_storage_service.dart';
import '../../../domain/entities/auth.dart';
import '../../../domain/usecases/login_user.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser _loginUser;
  final AuthStorageService _authStorageService;

  AuthCubit({
    required LoginUser loginUser,
    required AuthStorageService authStorageService,
  })  : _loginUser = loginUser,
        _authStorageService = authStorageService,
        super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());
    
    final auth = await _authStorageService.getAuth();
    if (auth != null) {
      emit(AuthState.authenticated(auth));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final failureOrAuth = await _loginUser(LoginParams(
      email: email,
      password: password,
    ));

    await failureOrAuth.fold(
      (failure) async => emit(const AuthState.error('Login failed. Please try again.')),
      (auth) async {
        await _authStorageService.saveAuth(auth);
        emit(AuthState.authenticated(auth));
      },
    );
  }

  Future<void> logout() async {
    await _authStorageService.clearAuth();
    emit(const AuthState.unauthenticated());
  }
}
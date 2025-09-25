import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/auth.dart';
import '../../../domain/usecases/login_user.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser _loginUser;

  AuthCubit({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final failureOrAuth = await _loginUser(LoginParams(
      email: email,
      password: password,
    ));

    failureOrAuth.fold(
      (failure) => emit(const AuthState.error('Login failed. Please try again.')),
      (auth) => emit(AuthState.authenticated(auth)),
    );
  }

  void logout() {
    emit(const AuthState.unauthenticated());
  }
}
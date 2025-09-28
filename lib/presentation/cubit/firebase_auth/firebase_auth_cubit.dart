import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/services/firebase_auth_service.dart';

part 'firebase_auth_state.dart';
part 'firebase_auth_cubit.freezed.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  final FirebaseAuthService _authService;

  FirebaseAuthCubit(this._authService) : super(const FirebaseAuthState.initial()) {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      if (user != null) {
        emit(FirebaseAuthState.authenticated(user));
      } else {
        emit(const FirebaseAuthState.unauthenticated());
      }
    });
  }

  // Sign up with email and password
  Future<void> signUp(String email, String password, String displayName) async {
    emit(const FirebaseAuthState.loading());
    try {
      final userCredential = await _authService.signUpWithEmailAndPassword(
        email,
        password,
        displayName,
      );
      
      if (userCredential?.user != null) {
        emit(FirebaseAuthState.authenticated(userCredential!.user!));
      }
    } catch (e) {
      emit(FirebaseAuthState.error(e.toString()));
    }
  }

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    emit(const FirebaseAuthState.loading());
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      
      if (userCredential?.user != null) {
        emit(FirebaseAuthState.authenticated(userCredential!.user!));
      }
    } catch (e) {
      emit(FirebaseAuthState.error(e.toString()));
    }
  }

  // Sign out
  Future<void> signOut() async {
    emit(const FirebaseAuthState.loading());
    try {
      await _authService.updateOnlineStatus(false);
      await _authService.signOut();
      emit(const FirebaseAuthState.unauthenticated());
    } catch (e) {
      emit(FirebaseAuthState.error(e.toString()));
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    emit(const FirebaseAuthState.loading());
    try {
      await _authService.resetPassword(email);
      emit(const FirebaseAuthState.passwordResetSent());
    } catch (e) {
      emit(FirebaseAuthState.error(e.toString()));
    }
  }

  // Check if user is authenticated
  bool get isAuthenticated => _authService.currentUser != null;

  // Get current user
  User? get currentUser => _authService.currentUser;

  // Update online status
  Future<void> updateOnlineStatus(bool isOnline) async {
    await _authService.updateOnlineStatus(isOnline);
  }
}
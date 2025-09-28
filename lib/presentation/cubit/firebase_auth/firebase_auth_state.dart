part of 'firebase_auth_cubit.dart';

@freezed
class FirebaseAuthState with _$FirebaseAuthState {
  const factory FirebaseAuthState.initial() = _Initial;
  const factory FirebaseAuthState.loading() = _Loading;
  const factory FirebaseAuthState.authenticated(User user) = _Authenticated;
  const factory FirebaseAuthState.unauthenticated() = _Unauthenticated;
  const factory FirebaseAuthState.error(String message) = _Error;
  const factory FirebaseAuthState.passwordResetSent() = _PasswordResetSent;
}
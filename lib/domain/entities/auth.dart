import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final String email;

  const Auth({
    required this.token,
    required this.email,
  });

  @override
  List<Object> get props => [token, email];
}
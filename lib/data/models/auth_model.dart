import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/auth.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
@HiveType(typeId: 1)
class AuthModel with _$AuthModel {
  const factory AuthModel({
    @HiveField(0) required String token,
    @HiveField(1) required String email,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
  
  const AuthModel._();
  
  Auth toDomain() {
    return Auth(
      token: token,
      email: email,
    );
  }
  
  factory AuthModel.fromDomain(Auth auth) {
    return AuthModel(
      token: auth.token,
      email: auth.email,
    );
  }
}
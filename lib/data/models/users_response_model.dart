import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'users_response_model.freezed.dart';
part 'users_response_model.g.dart';

@freezed
class UsersResponseModel with _$UsersResponseModel {
  const factory UsersResponseModel({
    required int page,
    @JsonKey(name: 'per_page') required int perPage,
    required int total,
    @JsonKey(name: 'total_pages') required int totalPages,
    required List<UserModel> data,
  }) = _UsersResponseModel;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => _$UsersResponseModelFromJson(json);
}
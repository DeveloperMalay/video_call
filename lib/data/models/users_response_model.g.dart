// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsersResponseModelImpl _$$UsersResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UsersResponseModelImpl(
      page: (json['page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UsersResponseModelImplToJson(
        _$UsersResponseModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
      'data': instance.data,
    };

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UsersResponseModel _$UsersResponseModelFromJson(Map<String, dynamic> json) {
  return _UsersResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UsersResponseModel {
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  List<UserModel> get data => throw _privateConstructorUsedError;

  /// Serializes this UsersResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsersResponseModelCopyWith<UsersResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersResponseModelCopyWith<$Res> {
  factory $UsersResponseModelCopyWith(
          UsersResponseModel value, $Res Function(UsersResponseModel) then) =
      _$UsersResponseModelCopyWithImpl<$Res, UsersResponseModel>;
  @useResult
  $Res call(
      {int page,
      @JsonKey(name: 'per_page') int perPage,
      int total,
      @JsonKey(name: 'total_pages') int totalPages,
      List<UserModel> data});
}

/// @nodoc
class _$UsersResponseModelCopyWithImpl<$Res, $Val extends UsersResponseModel>
    implements $UsersResponseModelCopyWith<$Res> {
  _$UsersResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? total = null,
    Object? totalPages = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsersResponseModelImplCopyWith<$Res>
    implements $UsersResponseModelCopyWith<$Res> {
  factory _$$UsersResponseModelImplCopyWith(_$UsersResponseModelImpl value,
          $Res Function(_$UsersResponseModelImpl) then) =
      __$$UsersResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      @JsonKey(name: 'per_page') int perPage,
      int total,
      @JsonKey(name: 'total_pages') int totalPages,
      List<UserModel> data});
}

/// @nodoc
class __$$UsersResponseModelImplCopyWithImpl<$Res>
    extends _$UsersResponseModelCopyWithImpl<$Res, _$UsersResponseModelImpl>
    implements _$$UsersResponseModelImplCopyWith<$Res> {
  __$$UsersResponseModelImplCopyWithImpl(_$UsersResponseModelImpl _value,
      $Res Function(_$UsersResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
    Object? total = null,
    Object? totalPages = null,
    Object? data = null,
  }) {
    return _then(_$UsersResponseModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsersResponseModelImpl implements _UsersResponseModel {
  const _$UsersResponseModelImpl(
      {required this.page,
      @JsonKey(name: 'per_page') required this.perPage,
      required this.total,
      @JsonKey(name: 'total_pages') required this.totalPages,
      required final List<UserModel> data})
      : _data = data;

  factory _$UsersResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsersResponseModelImplFromJson(json);

  @override
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  final int total;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<UserModel> _data;
  @override
  List<UserModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'UsersResponseModel(page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersResponseModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, perPage, total, totalPages,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of UsersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersResponseModelImplCopyWith<_$UsersResponseModelImpl> get copyWith =>
      __$$UsersResponseModelImplCopyWithImpl<_$UsersResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsersResponseModelImplToJson(
      this,
    );
  }
}

abstract class _UsersResponseModel implements UsersResponseModel {
  const factory _UsersResponseModel(
      {required final int page,
      @JsonKey(name: 'per_page') required final int perPage,
      required final int total,
      @JsonKey(name: 'total_pages') required final int totalPages,
      required final List<UserModel> data}) = _$UsersResponseModelImpl;

  factory _UsersResponseModel.fromJson(Map<String, dynamic> json) =
      _$UsersResponseModelImpl.fromJson;

  @override
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  int get total;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  List<UserModel> get data;

  /// Create a copy of UsersResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersResponseModelImplCopyWith<_$UsersResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

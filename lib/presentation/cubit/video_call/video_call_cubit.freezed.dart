// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_call_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoCallState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCallStateCopyWith<$Res> {
  factory $VideoCallStateCopyWith(
          VideoCallState value, $Res Function(VideoCallState) then) =
      _$VideoCallStateCopyWithImpl<$Res, VideoCallState>;
}

/// @nodoc
class _$VideoCallStateCopyWithImpl<$Res, $Val extends VideoCallState>
    implements $VideoCallStateCopyWith<$Res> {
  _$VideoCallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'VideoCallState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements VideoCallState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$ConnectingImplCopyWith<$Res> {
  factory _$$ConnectingImplCopyWith(
          _$ConnectingImpl value, $Res Function(_$ConnectingImpl) then) =
      __$$ConnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectingImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$ConnectingImpl>
    implements _$$ConnectingImplCopyWith<$Res> {
  __$$ConnectingImplCopyWithImpl(
      _$ConnectingImpl _value, $Res Function(_$ConnectingImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectingImpl implements _Connecting {
  const _$ConnectingImpl();

  @override
  String toString() {
    return 'VideoCallState.connecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return connecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return connecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class _Connecting implements VideoCallState {
  const factory _Connecting() = _$ConnectingImpl;
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
          _$ConnectedImpl value, $Res Function(_$ConnectedImpl) then) =
      __$$ConnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String meetingId});
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
      _$ConnectedImpl _value, $Res Function(_$ConnectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
  }) {
    return _then(_$ConnectedImpl(
      null == meetingId
          ? _value.meetingId
          : meetingId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectedImpl implements _Connected {
  const _$ConnectedImpl(this.meetingId);

  @override
  final String meetingId;

  @override
  String toString() {
    return 'VideoCallState.connected(meetingId: $meetingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedImpl &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      __$$ConnectedImplCopyWithImpl<_$ConnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return connected(meetingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return connected?.call(meetingId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(meetingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class _Connected implements VideoCallState {
  const factory _Connected(final String meetingId) = _$ConnectedImpl;

  String get meetingId;

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DisconnectedImplCopyWith<$Res> {
  factory _$$DisconnectedImplCopyWith(
          _$DisconnectedImpl value, $Res Function(_$DisconnectedImpl) then) =
      __$$DisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectedImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
      _$DisconnectedImpl _value, $Res Function(_$DisconnectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectedImpl implements _Disconnected {
  const _$DisconnectedImpl();

  @override
  String toString() {
    return 'VideoCallState.disconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisconnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return disconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return disconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class _Disconnected implements VideoCallState {
  const factory _Disconnected() = _$DisconnectedImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'VideoCallState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements VideoCallState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AudioMutedImplCopyWith<$Res> {
  factory _$$AudioMutedImplCopyWith(
          _$AudioMutedImpl value, $Res Function(_$AudioMutedImpl) then) =
      __$$AudioMutedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isMuted});
}

/// @nodoc
class __$$AudioMutedImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$AudioMutedImpl>
    implements _$$AudioMutedImplCopyWith<$Res> {
  __$$AudioMutedImplCopyWithImpl(
      _$AudioMutedImpl _value, $Res Function(_$AudioMutedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMuted = null,
  }) {
    return _then(_$AudioMutedImpl(
      null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AudioMutedImpl implements _AudioMuted {
  const _$AudioMutedImpl(this.isMuted);

  @override
  final bool isMuted;

  @override
  String toString() {
    return 'VideoCallState.audioMuted(isMuted: $isMuted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioMutedImpl &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isMuted);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioMutedImplCopyWith<_$AudioMutedImpl> get copyWith =>
      __$$AudioMutedImplCopyWithImpl<_$AudioMutedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return audioMuted(isMuted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return audioMuted?.call(isMuted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (audioMuted != null) {
      return audioMuted(isMuted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return audioMuted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return audioMuted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (audioMuted != null) {
      return audioMuted(this);
    }
    return orElse();
  }
}

abstract class _AudioMuted implements VideoCallState {
  const factory _AudioMuted(final bool isMuted) = _$AudioMutedImpl;

  bool get isMuted;

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioMutedImplCopyWith<_$AudioMutedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VideoEnabledImplCopyWith<$Res> {
  factory _$$VideoEnabledImplCopyWith(
          _$VideoEnabledImpl value, $Res Function(_$VideoEnabledImpl) then) =
      __$$VideoEnabledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class __$$VideoEnabledImplCopyWithImpl<$Res>
    extends _$VideoCallStateCopyWithImpl<$Res, _$VideoEnabledImpl>
    implements _$$VideoEnabledImplCopyWith<$Res> {
  __$$VideoEnabledImplCopyWithImpl(
      _$VideoEnabledImpl _value, $Res Function(_$VideoEnabledImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_$VideoEnabledImpl(
      null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VideoEnabledImpl implements _VideoEnabled {
  const _$VideoEnabledImpl(this.isEnabled);

  @override
  final bool isEnabled;

  @override
  String toString() {
    return 'VideoCallState.videoEnabled(isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoEnabledImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled);

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoEnabledImplCopyWith<_$VideoEnabledImpl> get copyWith =>
      __$$VideoEnabledImplCopyWithImpl<_$VideoEnabledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() connecting,
    required TResult Function(String meetingId) connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(bool isMuted) audioMuted,
    required TResult Function(bool isEnabled) videoEnabled,
  }) {
    return videoEnabled(isEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? connecting,
    TResult? Function(String meetingId)? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(bool isMuted)? audioMuted,
    TResult? Function(bool isEnabled)? videoEnabled,
  }) {
    return videoEnabled?.call(isEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? connecting,
    TResult Function(String meetingId)? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(bool isMuted)? audioMuted,
    TResult Function(bool isEnabled)? videoEnabled,
    required TResult orElse(),
  }) {
    if (videoEnabled != null) {
      return videoEnabled(isEnabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Error value) error,
    required TResult Function(_AudioMuted value) audioMuted,
    required TResult Function(_VideoEnabled value) videoEnabled,
  }) {
    return videoEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Error value)? error,
    TResult? Function(_AudioMuted value)? audioMuted,
    TResult? Function(_VideoEnabled value)? videoEnabled,
  }) {
    return videoEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Error value)? error,
    TResult Function(_AudioMuted value)? audioMuted,
    TResult Function(_VideoEnabled value)? videoEnabled,
    required TResult orElse(),
  }) {
    if (videoEnabled != null) {
      return videoEnabled(this);
    }
    return orElse();
  }
}

abstract class _VideoEnabled implements VideoCallState {
  const factory _VideoEnabled(final bool isEnabled) = _$VideoEnabledImpl;

  bool get isEnabled;

  /// Create a copy of VideoCallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoEnabledImplCopyWith<_$VideoEnabledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

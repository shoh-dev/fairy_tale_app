// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StateResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() ok,
    required TResult Function() loading,
    required TResult Function(ErrorX error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? ok,
    TResult? Function()? loading,
    TResult? Function(ErrorX error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? ok,
    TResult Function()? loading,
    TResult Function(ErrorX error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StateResultOkX value) ok,
    required TResult Function(StateResultLoadingX value) loading,
    required TResult Function(StateResultError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StateResultOkX value)? ok,
    TResult? Function(StateResultLoadingX value)? loading,
    TResult? Function(StateResultError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StateResultOkX value)? ok,
    TResult Function(StateResultLoadingX value)? loading,
    TResult Function(StateResultError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateResultCopyWith<$Res> {
  factory $StateResultCopyWith(
          StateResult value, $Res Function(StateResult) then) =
      _$StateResultCopyWithImpl<$Res, StateResult>;
}

/// @nodoc
class _$StateResultCopyWithImpl<$Res, $Val extends StateResult>
    implements $StateResultCopyWith<$Res> {
  _$StateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StateResultOkXImplCopyWith<$Res> {
  factory _$$StateResultOkXImplCopyWith(_$StateResultOkXImpl value,
          $Res Function(_$StateResultOkXImpl) then) =
      __$$StateResultOkXImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StateResultOkXImplCopyWithImpl<$Res>
    extends _$StateResultCopyWithImpl<$Res, _$StateResultOkXImpl>
    implements _$$StateResultOkXImplCopyWith<$Res> {
  __$$StateResultOkXImplCopyWithImpl(
      _$StateResultOkXImpl _value, $Res Function(_$StateResultOkXImpl) _then)
      : super(_value, _then);

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StateResultOkXImpl implements StateResultOkX {
  const _$StateResultOkXImpl();

  @override
  String toString() {
    return 'StateResult.ok()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StateResultOkXImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() ok,
    required TResult Function() loading,
    required TResult Function(ErrorX error) error,
  }) {
    return ok();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? ok,
    TResult? Function()? loading,
    TResult? Function(ErrorX error)? error,
  }) {
    return ok?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? ok,
    TResult Function()? loading,
    TResult Function(ErrorX error)? error,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StateResultOkX value) ok,
    required TResult Function(StateResultLoadingX value) loading,
    required TResult Function(StateResultError value) error,
  }) {
    return ok(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StateResultOkX value)? ok,
    TResult? Function(StateResultLoadingX value)? loading,
    TResult? Function(StateResultError value)? error,
  }) {
    return ok?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StateResultOkX value)? ok,
    TResult Function(StateResultLoadingX value)? loading,
    TResult Function(StateResultError value)? error,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok(this);
    }
    return orElse();
  }
}

abstract class StateResultOkX implements StateResult {
  const factory StateResultOkX() = _$StateResultOkXImpl;
}

/// @nodoc
abstract class _$$StateResultLoadingXImplCopyWith<$Res> {
  factory _$$StateResultLoadingXImplCopyWith(_$StateResultLoadingXImpl value,
          $Res Function(_$StateResultLoadingXImpl) then) =
      __$$StateResultLoadingXImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StateResultLoadingXImplCopyWithImpl<$Res>
    extends _$StateResultCopyWithImpl<$Res, _$StateResultLoadingXImpl>
    implements _$$StateResultLoadingXImplCopyWith<$Res> {
  __$$StateResultLoadingXImplCopyWithImpl(_$StateResultLoadingXImpl _value,
      $Res Function(_$StateResultLoadingXImpl) _then)
      : super(_value, _then);

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StateResultLoadingXImpl implements StateResultLoadingX {
  const _$StateResultLoadingXImpl();

  @override
  String toString() {
    return 'StateResult.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateResultLoadingXImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() ok,
    required TResult Function() loading,
    required TResult Function(ErrorX error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? ok,
    TResult? Function()? loading,
    TResult? Function(ErrorX error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? ok,
    TResult Function()? loading,
    TResult Function(ErrorX error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StateResultOkX value) ok,
    required TResult Function(StateResultLoadingX value) loading,
    required TResult Function(StateResultError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StateResultOkX value)? ok,
    TResult? Function(StateResultLoadingX value)? loading,
    TResult? Function(StateResultError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StateResultOkX value)? ok,
    TResult Function(StateResultLoadingX value)? loading,
    TResult Function(StateResultError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StateResultLoadingX implements StateResult {
  const factory StateResultLoadingX() = _$StateResultLoadingXImpl;
}

/// @nodoc
abstract class _$$StateResultErrorImplCopyWith<$Res> {
  factory _$$StateResultErrorImplCopyWith(_$StateResultErrorImpl value,
          $Res Function(_$StateResultErrorImpl) then) =
      __$$StateResultErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorX error});

  $ErrorXCopyWith<$Res> get error;
}

/// @nodoc
class __$$StateResultErrorImplCopyWithImpl<$Res>
    extends _$StateResultCopyWithImpl<$Res, _$StateResultErrorImpl>
    implements _$$StateResultErrorImplCopyWith<$Res> {
  __$$StateResultErrorImplCopyWithImpl(_$StateResultErrorImpl _value,
      $Res Function(_$StateResultErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$StateResultErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorX,
    ));
  }

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorXCopyWith<$Res> get error {
    return $ErrorXCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$StateResultErrorImpl implements StateResultError {
  const _$StateResultErrorImpl(this.error);

  @override
  final ErrorX error;

  @override
  String toString() {
    return 'StateResult.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateResultErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StateResultErrorImplCopyWith<_$StateResultErrorImpl> get copyWith =>
      __$$StateResultErrorImplCopyWithImpl<_$StateResultErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() ok,
    required TResult Function() loading,
    required TResult Function(ErrorX error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? ok,
    TResult? Function()? loading,
    TResult? Function(ErrorX error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? ok,
    TResult Function()? loading,
    TResult Function(ErrorX error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StateResultOkX value) ok,
    required TResult Function(StateResultLoadingX value) loading,
    required TResult Function(StateResultError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StateResultOkX value)? ok,
    TResult? Function(StateResultLoadingX value)? loading,
    TResult? Function(StateResultError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StateResultOkX value)? ok,
    TResult Function(StateResultLoadingX value)? loading,
    TResult Function(StateResultError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class StateResultError implements StateResult {
  const factory StateResultError(final ErrorX error) = _$StateResultErrorImpl;

  ErrorX get error;

  /// Create a copy of StateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StateResultErrorImplCopyWith<_$StateResultErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

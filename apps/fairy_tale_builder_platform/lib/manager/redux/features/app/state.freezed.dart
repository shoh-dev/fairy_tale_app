// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApplicationState {
  LocalizationState get localizationState => throw _privateConstructorUsedError;
  LocalizationState2 get localizationState2 =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationStateCopyWith<ApplicationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationStateCopyWith<$Res> {
  factory $ApplicationStateCopyWith(
          ApplicationState value, $Res Function(ApplicationState) then) =
      _$ApplicationStateCopyWithImpl<$Res, ApplicationState>;
  @useResult
  $Res call(
      {LocalizationState localizationState,
      LocalizationState2 localizationState2});

  $LocalizationStateCopyWith<$Res> get localizationState;
  $LocalizationState2CopyWith<$Res> get localizationState2;
}

/// @nodoc
class _$ApplicationStateCopyWithImpl<$Res, $Val extends ApplicationState>
    implements $ApplicationStateCopyWith<$Res> {
  _$ApplicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localizationState = null,
    Object? localizationState2 = null,
  }) {
    return _then(_value.copyWith(
      localizationState: null == localizationState
          ? _value.localizationState
          : localizationState // ignore: cast_nullable_to_non_nullable
              as LocalizationState,
      localizationState2: null == localizationState2
          ? _value.localizationState2
          : localizationState2 // ignore: cast_nullable_to_non_nullable
              as LocalizationState2,
    ) as $Val);
  }

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalizationStateCopyWith<$Res> get localizationState {
    return $LocalizationStateCopyWith<$Res>(_value.localizationState, (value) {
      return _then(_value.copyWith(localizationState: value) as $Val);
    });
  }

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalizationState2CopyWith<$Res> get localizationState2 {
    return $LocalizationState2CopyWith<$Res>(_value.localizationState2,
        (value) {
      return _then(_value.copyWith(localizationState2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplicationStateImplCopyWith<$Res>
    implements $ApplicationStateCopyWith<$Res> {
  factory _$$ApplicationStateImplCopyWith(_$ApplicationStateImpl value,
          $Res Function(_$ApplicationStateImpl) then) =
      __$$ApplicationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LocalizationState localizationState,
      LocalizationState2 localizationState2});

  @override
  $LocalizationStateCopyWith<$Res> get localizationState;
  @override
  $LocalizationState2CopyWith<$Res> get localizationState2;
}

/// @nodoc
class __$$ApplicationStateImplCopyWithImpl<$Res>
    extends _$ApplicationStateCopyWithImpl<$Res, _$ApplicationStateImpl>
    implements _$$ApplicationStateImplCopyWith<$Res> {
  __$$ApplicationStateImplCopyWithImpl(_$ApplicationStateImpl _value,
      $Res Function(_$ApplicationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localizationState = null,
    Object? localizationState2 = null,
  }) {
    return _then(_$ApplicationStateImpl(
      localizationState: null == localizationState
          ? _value.localizationState
          : localizationState // ignore: cast_nullable_to_non_nullable
              as LocalizationState,
      localizationState2: null == localizationState2
          ? _value.localizationState2
          : localizationState2 // ignore: cast_nullable_to_non_nullable
              as LocalizationState2,
    ));
  }
}

/// @nodoc

class _$ApplicationStateImpl implements _ApplicationState {
  const _$ApplicationStateImpl(
      {required this.localizationState, required this.localizationState2});

  @override
  final LocalizationState localizationState;
  @override
  final LocalizationState2 localizationState2;

  @override
  String toString() {
    return 'ApplicationState(localizationState: $localizationState, localizationState2: $localizationState2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationStateImpl &&
            (identical(other.localizationState, localizationState) ||
                other.localizationState == localizationState) &&
            (identical(other.localizationState2, localizationState2) ||
                other.localizationState2 == localizationState2));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, localizationState, localizationState2);

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationStateImplCopyWith<_$ApplicationStateImpl> get copyWith =>
      __$$ApplicationStateImplCopyWithImpl<_$ApplicationStateImpl>(
          this, _$identity);
}

abstract class _ApplicationState implements ApplicationState {
  const factory _ApplicationState(
          {required final LocalizationState localizationState,
          required final LocalizationState2 localizationState2}) =
      _$ApplicationStateImpl;

  @override
  LocalizationState get localizationState;
  @override
  LocalizationState2 get localizationState2;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationStateImplCopyWith<_$ApplicationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

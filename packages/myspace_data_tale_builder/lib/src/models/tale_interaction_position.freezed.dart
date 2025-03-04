// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_interaction_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaleInteractionPosition _$TaleInteractionPositionFromJson(
    Map<String, dynamic> json) {
  return _TaleInteractionPosition.fromJson(json);
}

/// @nodoc
mixin _$TaleInteractionPosition {
  num get x => throw _privateConstructorUsedError;
  num get y => throw _privateConstructorUsedError;

  /// Serializes this TaleInteractionPosition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaleInteractionPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleInteractionPositionCopyWith<TaleInteractionPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleInteractionPositionCopyWith<$Res> {
  factory $TaleInteractionPositionCopyWith(TaleInteractionPosition value,
          $Res Function(TaleInteractionPosition) then) =
      _$TaleInteractionPositionCopyWithImpl<$Res, TaleInteractionPosition>;
  @useResult
  $Res call({num x, num y});
}

/// @nodoc
class _$TaleInteractionPositionCopyWithImpl<$Res,
        $Val extends TaleInteractionPosition>
    implements $TaleInteractionPositionCopyWith<$Res> {
  _$TaleInteractionPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleInteractionPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as num,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaleInteractionPositionImplCopyWith<$Res>
    implements $TaleInteractionPositionCopyWith<$Res> {
  factory _$$TaleInteractionPositionImplCopyWith(
          _$TaleInteractionPositionImpl value,
          $Res Function(_$TaleInteractionPositionImpl) then) =
      __$$TaleInteractionPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num x, num y});
}

/// @nodoc
class __$$TaleInteractionPositionImplCopyWithImpl<$Res>
    extends _$TaleInteractionPositionCopyWithImpl<$Res,
        _$TaleInteractionPositionImpl>
    implements _$$TaleInteractionPositionImplCopyWith<$Res> {
  __$$TaleInteractionPositionImplCopyWithImpl(
      _$TaleInteractionPositionImpl _value,
      $Res Function(_$TaleInteractionPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleInteractionPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$TaleInteractionPositionImpl(
      null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as num,
      null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@appJsonSerializable
class _$TaleInteractionPositionImpl extends _TaleInteractionPosition {
  const _$TaleInteractionPositionImpl(this.x, this.y) : super._();

  factory _$TaleInteractionPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleInteractionPositionImplFromJson(json);

  @override
  final num x;
  @override
  final num y;

  @override
  String toString() {
    return 'TaleInteractionPosition(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleInteractionPositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  /// Create a copy of TaleInteractionPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleInteractionPositionImplCopyWith<_$TaleInteractionPositionImpl>
      get copyWith => __$$TaleInteractionPositionImplCopyWithImpl<
          _$TaleInteractionPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleInteractionPositionImplToJson(
      this,
    );
  }
}

abstract class _TaleInteractionPosition extends TaleInteractionPosition {
  const factory _TaleInteractionPosition(final num x, final num y) =
      _$TaleInteractionPositionImpl;
  const _TaleInteractionPosition._() : super._();

  factory _TaleInteractionPosition.fromJson(Map<String, dynamic> json) =
      _$TaleInteractionPositionImpl.fromJson;

  @override
  num get x;
  @override
  num get y;

  /// Create a copy of TaleInteractionPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleInteractionPositionImplCopyWith<_$TaleInteractionPositionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_interaction_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaleInteractionSize _$TaleInteractionSizeFromJson(Map<String, dynamic> json) {
  return _TaleInteractionSize.fromJson(json);
}

/// @nodoc
mixin _$TaleInteractionSize {
  num get w => throw _privateConstructorUsedError;
  num get h => throw _privateConstructorUsedError;

  /// Serializes this TaleInteractionSize to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaleInteractionSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleInteractionSizeCopyWith<TaleInteractionSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleInteractionSizeCopyWith<$Res> {
  factory $TaleInteractionSizeCopyWith(
          TaleInteractionSize value, $Res Function(TaleInteractionSize) then) =
      _$TaleInteractionSizeCopyWithImpl<$Res, TaleInteractionSize>;
  @useResult
  $Res call({num w, num h});
}

/// @nodoc
class _$TaleInteractionSizeCopyWithImpl<$Res, $Val extends TaleInteractionSize>
    implements $TaleInteractionSizeCopyWith<$Res> {
  _$TaleInteractionSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleInteractionSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? w = null,
    Object? h = null,
  }) {
    return _then(_value.copyWith(
      w: null == w
          ? _value.w
          : w // ignore: cast_nullable_to_non_nullable
              as num,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaleInteractionSizeImplCopyWith<$Res>
    implements $TaleInteractionSizeCopyWith<$Res> {
  factory _$$TaleInteractionSizeImplCopyWith(_$TaleInteractionSizeImpl value,
          $Res Function(_$TaleInteractionSizeImpl) then) =
      __$$TaleInteractionSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num w, num h});
}

/// @nodoc
class __$$TaleInteractionSizeImplCopyWithImpl<$Res>
    extends _$TaleInteractionSizeCopyWithImpl<$Res, _$TaleInteractionSizeImpl>
    implements _$$TaleInteractionSizeImplCopyWith<$Res> {
  __$$TaleInteractionSizeImplCopyWithImpl(_$TaleInteractionSizeImpl _value,
      $Res Function(_$TaleInteractionSizeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleInteractionSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? w = null,
    Object? h = null,
  }) {
    return _then(_$TaleInteractionSizeImpl(
      null == w
          ? _value.w
          : w // ignore: cast_nullable_to_non_nullable
              as num,
      null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleInteractionSizeImpl extends _TaleInteractionSize {
  const _$TaleInteractionSizeImpl(this.w, this.h) : super._();

  factory _$TaleInteractionSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleInteractionSizeImplFromJson(json);

  @override
  final num w;
  @override
  final num h;

  @override
  String toString() {
    return 'TaleInteractionSize(w: $w, h: $h)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleInteractionSizeImpl &&
            (identical(other.w, w) || other.w == w) &&
            (identical(other.h, h) || other.h == h));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, w, h);

  /// Create a copy of TaleInteractionSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleInteractionSizeImplCopyWith<_$TaleInteractionSizeImpl> get copyWith =>
      __$$TaleInteractionSizeImplCopyWithImpl<_$TaleInteractionSizeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleInteractionSizeImplToJson(
      this,
    );
  }
}

abstract class _TaleInteractionSize extends TaleInteractionSize {
  const factory _TaleInteractionSize(final num w, final num h) =
      _$TaleInteractionSizeImpl;
  const _TaleInteractionSize._() : super._();

  factory _TaleInteractionSize.fromJson(Map<String, dynamic> json) =
      _$TaleInteractionSizeImpl.fromJson;

  @override
  num get w;
  @override
  num get h;

  /// Create a copy of TaleInteractionSize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleInteractionSizeImplCopyWith<_$TaleInteractionSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

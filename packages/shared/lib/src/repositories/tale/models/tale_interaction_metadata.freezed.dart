// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_interaction_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaleInteractionMetadata _$TaleInteractionMetadataFromJson(
    Map<String, dynamic> json) {
  return _TaleInteractionMetadata.fromJson(json);
}

/// @nodoc
mixin _$TaleInteractionMetadata {
  TaleInteractionSize get size => throw _privateConstructorUsedError;
  @JsonKey(name: 'initial_pos')
  TaleInteractionPosition get initialPosition =>
      throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_pos')
  TaleInteractionPosition? get finalPosition =>
      throw _privateConstructorUsedError;

  /// Serializes this TaleInteractionMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleInteractionMetadataCopyWith<TaleInteractionMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleInteractionMetadataCopyWith<$Res> {
  factory $TaleInteractionMetadataCopyWith(TaleInteractionMetadata value,
          $Res Function(TaleInteractionMetadata) then) =
      _$TaleInteractionMetadataCopyWithImpl<$Res, TaleInteractionMetadata>;
  @useResult
  $Res call(
      {TaleInteractionSize size,
      @JsonKey(name: 'initial_pos') TaleInteractionPosition initialPosition,
      String imageUrl,
      String audioUrl,
      @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition});

  $TaleInteractionSizeCopyWith<$Res> get size;
  $TaleInteractionPositionCopyWith<$Res> get initialPosition;
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition;
}

/// @nodoc
class _$TaleInteractionMetadataCopyWithImpl<$Res,
        $Val extends TaleInteractionMetadata>
    implements $TaleInteractionMetadataCopyWith<$Res> {
  _$TaleInteractionMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? initialPosition = null,
    Object? imageUrl = null,
    Object? audioUrl = null,
    Object? finalPosition = freezed,
  }) {
    return _then(_value.copyWith(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as TaleInteractionSize,
      initialPosition: null == initialPosition
          ? _value.initialPosition
          : initialPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      finalPosition: freezed == finalPosition
          ? _value.finalPosition
          : finalPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition?,
    ) as $Val);
  }

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionSizeCopyWith<$Res> get size {
    return $TaleInteractionSizeCopyWith<$Res>(_value.size, (value) {
      return _then(_value.copyWith(size: value) as $Val);
    });
  }

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionPositionCopyWith<$Res> get initialPosition {
    return $TaleInteractionPositionCopyWith<$Res>(_value.initialPosition,
        (value) {
      return _then(_value.copyWith(initialPosition: value) as $Val);
    });
  }

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition {
    if (_value.finalPosition == null) {
      return null;
    }

    return $TaleInteractionPositionCopyWith<$Res>(_value.finalPosition!,
        (value) {
      return _then(_value.copyWith(finalPosition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaleInteractionMetadataImplCopyWith<$Res>
    implements $TaleInteractionMetadataCopyWith<$Res> {
  factory _$$TaleInteractionMetadataImplCopyWith(
          _$TaleInteractionMetadataImpl value,
          $Res Function(_$TaleInteractionMetadataImpl) then) =
      __$$TaleInteractionMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TaleInteractionSize size,
      @JsonKey(name: 'initial_pos') TaleInteractionPosition initialPosition,
      String imageUrl,
      String audioUrl,
      @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition});

  @override
  $TaleInteractionSizeCopyWith<$Res> get size;
  @override
  $TaleInteractionPositionCopyWith<$Res> get initialPosition;
  @override
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition;
}

/// @nodoc
class __$$TaleInteractionMetadataImplCopyWithImpl<$Res>
    extends _$TaleInteractionMetadataCopyWithImpl<$Res,
        _$TaleInteractionMetadataImpl>
    implements _$$TaleInteractionMetadataImplCopyWith<$Res> {
  __$$TaleInteractionMetadataImplCopyWithImpl(
      _$TaleInteractionMetadataImpl _value,
      $Res Function(_$TaleInteractionMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? initialPosition = null,
    Object? imageUrl = null,
    Object? audioUrl = null,
    Object? finalPosition = freezed,
  }) {
    return _then(_$TaleInteractionMetadataImpl(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as TaleInteractionSize,
      initialPosition: null == initialPosition
          ? _value.initialPosition
          : initialPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      finalPosition: freezed == finalPosition
          ? _value.finalPosition
          : finalPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleInteractionMetadataImpl extends _TaleInteractionMetadata {
  const _$TaleInteractionMetadataImpl(
      {this.size = const TaleInteractionSize(40, 40),
      @JsonKey(name: 'initial_pos')
      this.initialPosition = TaleInteractionPosition.zero,
      this.imageUrl = '',
      this.audioUrl = '',
      @JsonKey(name: 'final_pos') this.finalPosition})
      : super._();

  factory _$TaleInteractionMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleInteractionMetadataImplFromJson(json);

  @override
  @JsonKey()
  final TaleInteractionSize size;
  @override
  @JsonKey(name: 'initial_pos')
  final TaleInteractionPosition initialPosition;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String audioUrl;
  @override
  @JsonKey(name: 'final_pos')
  final TaleInteractionPosition? finalPosition;

  @override
  String toString() {
    return 'TaleInteractionMetadata(size: $size, initialPosition: $initialPosition, imageUrl: $imageUrl, audioUrl: $audioUrl, finalPosition: $finalPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleInteractionMetadataImpl &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.initialPosition, initialPosition) ||
                other.initialPosition == initialPosition) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.finalPosition, finalPosition) ||
                other.finalPosition == finalPosition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, size, initialPosition, imageUrl, audioUrl, finalPosition);

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleInteractionMetadataImplCopyWith<_$TaleInteractionMetadataImpl>
      get copyWith => __$$TaleInteractionMetadataImplCopyWithImpl<
          _$TaleInteractionMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleInteractionMetadataImplToJson(
      this,
    );
  }
}

abstract class _TaleInteractionMetadata extends TaleInteractionMetadata {
  const factory _TaleInteractionMetadata(
          {final TaleInteractionSize size,
          @JsonKey(name: 'initial_pos')
          final TaleInteractionPosition initialPosition,
          final String imageUrl,
          final String audioUrl,
          @JsonKey(name: 'final_pos')
          final TaleInteractionPosition? finalPosition}) =
      _$TaleInteractionMetadataImpl;
  const _TaleInteractionMetadata._() : super._();

  factory _TaleInteractionMetadata.fromJson(Map<String, dynamic> json) =
      _$TaleInteractionMetadataImpl.fromJson;

  @override
  TaleInteractionSize get size;
  @override
  @JsonKey(name: 'initial_pos')
  TaleInteractionPosition get initialPosition;
  @override
  String get imageUrl;
  @override
  String get audioUrl;
  @override
  @JsonKey(name: 'final_pos')
  TaleInteractionPosition? get finalPosition;

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleInteractionMetadataImplCopyWith<_$TaleInteractionMetadataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

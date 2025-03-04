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
  String get imageUrl => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;

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
  $Res call({String imageUrl, String audioUrl});
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
    Object? imageUrl = null,
    Object? audioUrl = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
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
  $Res call({String imageUrl, String audioUrl});
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
    Object? imageUrl = null,
    Object? audioUrl = null,
  }) {
    return _then(_$TaleInteractionMetadataImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleInteractionMetadataImpl extends _TaleInteractionMetadata {
  const _$TaleInteractionMetadataImpl({this.imageUrl = '', this.audioUrl = ''})
      : super._();

  factory _$TaleInteractionMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleInteractionMetadataImplFromJson(json);

  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String audioUrl;

  @override
  String toString() {
    return 'TaleInteractionMetadata(imageUrl: $imageUrl, audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleInteractionMetadataImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, audioUrl);

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
      {final String imageUrl,
      final String audioUrl}) = _$TaleInteractionMetadataImpl;
  const _TaleInteractionMetadata._() : super._();

  factory _TaleInteractionMetadata.fromJson(Map<String, dynamic> json) =
      _$TaleInteractionMetadataImpl.fromJson;

  @override
  String get imageUrl;
  @override
  String get audioUrl;

  /// Create a copy of TaleInteractionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleInteractionMetadataImplCopyWith<_$TaleInteractionMetadataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

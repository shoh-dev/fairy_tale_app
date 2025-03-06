// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_page_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TalePageMetadata _$TalePageMetadataFromJson(Map<String, dynamic> json) {
  return _TalePageMetadata.fromJson(json);
}

/// @nodoc
mixin _$TalePageMetadata {
  String get backgroundImageUrl => throw _privateConstructorUsedError;
  String get backgroundAudioUrl => throw _privateConstructorUsedError;

  /// Serializes this TalePageMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TalePageMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TalePageMetadataCopyWith<TalePageMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalePageMetadataCopyWith<$Res> {
  factory $TalePageMetadataCopyWith(
          TalePageMetadata value, $Res Function(TalePageMetadata) then) =
      _$TalePageMetadataCopyWithImpl<$Res, TalePageMetadata>;
  @useResult
  $Res call({String backgroundImageUrl, String backgroundAudioUrl});
}

/// @nodoc
class _$TalePageMetadataCopyWithImpl<$Res, $Val extends TalePageMetadata>
    implements $TalePageMetadataCopyWith<$Res> {
  _$TalePageMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TalePageMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundImageUrl = null,
    Object? backgroundAudioUrl = null,
  }) {
    return _then(_value.copyWith(
      backgroundImageUrl: null == backgroundImageUrl
          ? _value.backgroundImageUrl
          : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudioUrl: null == backgroundAudioUrl
          ? _value.backgroundAudioUrl
          : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalePageMetadataImplCopyWith<$Res>
    implements $TalePageMetadataCopyWith<$Res> {
  factory _$$TalePageMetadataImplCopyWith(_$TalePageMetadataImpl value,
          $Res Function(_$TalePageMetadataImpl) then) =
      __$$TalePageMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String backgroundImageUrl, String backgroundAudioUrl});
}

/// @nodoc
class __$$TalePageMetadataImplCopyWithImpl<$Res>
    extends _$TalePageMetadataCopyWithImpl<$Res, _$TalePageMetadataImpl>
    implements _$$TalePageMetadataImplCopyWith<$Res> {
  __$$TalePageMetadataImplCopyWithImpl(_$TalePageMetadataImpl _value,
      $Res Function(_$TalePageMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TalePageMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundImageUrl = null,
    Object? backgroundAudioUrl = null,
  }) {
    return _then(_$TalePageMetadataImpl(
      backgroundImageUrl: null == backgroundImageUrl
          ? _value.backgroundImageUrl
          : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudioUrl: null == backgroundAudioUrl
          ? _value.backgroundAudioUrl
          : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TalePageMetadataImpl extends _TalePageMetadata {
  const _$TalePageMetadataImpl(
      {this.backgroundImageUrl = '', this.backgroundAudioUrl = ''})
      : super._();

  factory _$TalePageMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TalePageMetadataImplFromJson(json);

  @override
  @JsonKey()
  final String backgroundImageUrl;
  @override
  @JsonKey()
  final String backgroundAudioUrl;

  @override
  String toString() {
    return 'TalePageMetadata(backgroundImageUrl: $backgroundImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalePageMetadataImpl &&
            (identical(other.backgroundImageUrl, backgroundImageUrl) ||
                other.backgroundImageUrl == backgroundImageUrl) &&
            (identical(other.backgroundAudioUrl, backgroundAudioUrl) ||
                other.backgroundAudioUrl == backgroundAudioUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, backgroundImageUrl, backgroundAudioUrl);

  /// Create a copy of TalePageMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TalePageMetadataImplCopyWith<_$TalePageMetadataImpl> get copyWith =>
      __$$TalePageMetadataImplCopyWithImpl<_$TalePageMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TalePageMetadataImplToJson(
      this,
    );
  }
}

abstract class _TalePageMetadata extends TalePageMetadata {
  const factory _TalePageMetadata(
      {final String backgroundImageUrl,
      final String backgroundAudioUrl}) = _$TalePageMetadataImpl;
  const _TalePageMetadata._() : super._();

  factory _TalePageMetadata.fromJson(Map<String, dynamic> json) =
      _$TalePageMetadataImpl.fromJson;

  @override
  String get backgroundImageUrl;
  @override
  String get backgroundAudioUrl;

  /// Create a copy of TalePageMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalePageMetadataImplCopyWith<_$TalePageMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

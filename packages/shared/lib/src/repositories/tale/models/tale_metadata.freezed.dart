// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaleMetadata {
  String get coverImageUrl => throw _privateConstructorUsedError;
  String get backgroundAudioUrl => throw _privateConstructorUsedError;

  /// Create a copy of TaleMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleMetadataCopyWith<TaleMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleMetadataCopyWith<$Res> {
  factory $TaleMetadataCopyWith(
          TaleMetadata value, $Res Function(TaleMetadata) then) =
      _$TaleMetadataCopyWithImpl<$Res, TaleMetadata>;
  @useResult
  $Res call({String coverImageUrl, String backgroundAudioUrl});
}

/// @nodoc
class _$TaleMetadataCopyWithImpl<$Res, $Val extends TaleMetadata>
    implements $TaleMetadataCopyWith<$Res> {
  _$TaleMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverImageUrl = null,
    Object? backgroundAudioUrl = null,
  }) {
    return _then(_value.copyWith(
      coverImageUrl: null == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudioUrl: null == backgroundAudioUrl
          ? _value.backgroundAudioUrl
          : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaleMetadataImplCopyWith<$Res>
    implements $TaleMetadataCopyWith<$Res> {
  factory _$$TaleMetadataImplCopyWith(
          _$TaleMetadataImpl value, $Res Function(_$TaleMetadataImpl) then) =
      __$$TaleMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String coverImageUrl, String backgroundAudioUrl});
}

/// @nodoc
class __$$TaleMetadataImplCopyWithImpl<$Res>
    extends _$TaleMetadataCopyWithImpl<$Res, _$TaleMetadataImpl>
    implements _$$TaleMetadataImplCopyWith<$Res> {
  __$$TaleMetadataImplCopyWithImpl(
      _$TaleMetadataImpl _value, $Res Function(_$TaleMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverImageUrl = null,
    Object? backgroundAudioUrl = null,
  }) {
    return _then(_$TaleMetadataImpl(
      coverImageUrl: null == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudioUrl: null == backgroundAudioUrl
          ? _value.backgroundAudioUrl
          : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaleMetadataImpl extends _TaleMetadata {
  const _$TaleMetadataImpl(
      {this.coverImageUrl = '', this.backgroundAudioUrl = ''})
      : super._();

  @override
  @JsonKey()
  final String coverImageUrl;
  @override
  @JsonKey()
  final String backgroundAudioUrl;

  @override
  String toString() {
    return 'TaleMetadata(coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleMetadataImpl &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.backgroundAudioUrl, backgroundAudioUrl) ||
                other.backgroundAudioUrl == backgroundAudioUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, coverImageUrl, backgroundAudioUrl);

  /// Create a copy of TaleMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleMetadataImplCopyWith<_$TaleMetadataImpl> get copyWith =>
      __$$TaleMetadataImplCopyWithImpl<_$TaleMetadataImpl>(this, _$identity);
}

abstract class _TaleMetadata extends TaleMetadata {
  const factory _TaleMetadata(
      {final String coverImageUrl,
      final String backgroundAudioUrl}) = _$TaleMetadataImpl;
  const _TaleMetadata._() : super._();

  @override
  String get coverImageUrl;
  @override
  String get backgroundAudioUrl;

  /// Create a copy of TaleMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleMetadataImplCopyWith<_$TaleMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

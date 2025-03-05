// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_localization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaleLocalization _$TaleLocalizationFromJson(Map<String, dynamic> json) {
  return _TaleLocalization.fromJson(json);
}

/// @nodoc
mixin _$TaleLocalization {
  String get id => throw _privateConstructorUsedError;
  String get taleId => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get translations =>
      throw _privateConstructorUsedError;
  String get defaultLocale => throw _privateConstructorUsedError;

  /// Serializes this TaleLocalization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaleLocalization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleLocalizationCopyWith<TaleLocalization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleLocalizationCopyWith<$Res> {
  factory $TaleLocalizationCopyWith(
          TaleLocalization value, $Res Function(TaleLocalization) then) =
      _$TaleLocalizationCopyWithImpl<$Res, TaleLocalization>;
  @useResult
  $Res call(
      {String id,
      String taleId,
      Map<String, Map<String, String>> translations,
      String defaultLocale});
}

/// @nodoc
class _$TaleLocalizationCopyWithImpl<$Res, $Val extends TaleLocalization>
    implements $TaleLocalizationCopyWith<$Res> {
  _$TaleLocalizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleLocalization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taleId = null,
    Object? translations = null,
    Object? defaultLocale = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taleId: null == taleId
          ? _value.taleId
          : taleId // ignore: cast_nullable_to_non_nullable
              as String,
      translations: null == translations
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      defaultLocale: null == defaultLocale
          ? _value.defaultLocale
          : defaultLocale // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaleLocalizationImplCopyWith<$Res>
    implements $TaleLocalizationCopyWith<$Res> {
  factory _$$TaleLocalizationImplCopyWith(_$TaleLocalizationImpl value,
          $Res Function(_$TaleLocalizationImpl) then) =
      __$$TaleLocalizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String taleId,
      Map<String, Map<String, String>> translations,
      String defaultLocale});
}

/// @nodoc
class __$$TaleLocalizationImplCopyWithImpl<$Res>
    extends _$TaleLocalizationCopyWithImpl<$Res, _$TaleLocalizationImpl>
    implements _$$TaleLocalizationImplCopyWith<$Res> {
  __$$TaleLocalizationImplCopyWithImpl(_$TaleLocalizationImpl _value,
      $Res Function(_$TaleLocalizationImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleLocalization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taleId = null,
    Object? translations = null,
    Object? defaultLocale = null,
  }) {
    return _then(_$TaleLocalizationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taleId: null == taleId
          ? _value.taleId
          : taleId // ignore: cast_nullable_to_non_nullable
              as String,
      translations: null == translations
          ? _value._translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      defaultLocale: null == defaultLocale
          ? _value.defaultLocale
          : defaultLocale // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleLocalizationImpl extends _TaleLocalization {
  const _$TaleLocalizationImpl(
      {required this.id,
      required this.taleId,
      required final Map<String, Map<String, String>> translations,
      required this.defaultLocale})
      : _translations = translations,
        super._();

  factory _$TaleLocalizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleLocalizationImplFromJson(json);

  @override
  final String id;
  @override
  final String taleId;
  final Map<String, Map<String, String>> _translations;
  @override
  Map<String, Map<String, String>> get translations {
    if (_translations is EqualUnmodifiableMapView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_translations);
  }

  @override
  final String defaultLocale;

  @override
  String toString() {
    return 'TaleLocalization(id: $id, taleId: $taleId, translations: $translations, defaultLocale: $defaultLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleLocalizationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taleId, taleId) || other.taleId == taleId) &&
            const DeepCollectionEquality()
                .equals(other._translations, _translations) &&
            (identical(other.defaultLocale, defaultLocale) ||
                other.defaultLocale == defaultLocale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taleId,
      const DeepCollectionEquality().hash(_translations), defaultLocale);

  /// Create a copy of TaleLocalization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleLocalizationImplCopyWith<_$TaleLocalizationImpl> get copyWith =>
      __$$TaleLocalizationImplCopyWithImpl<_$TaleLocalizationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleLocalizationImplToJson(
      this,
    );
  }
}

abstract class _TaleLocalization extends TaleLocalization {
  const factory _TaleLocalization(
      {required final String id,
      required final String taleId,
      required final Map<String, Map<String, String>> translations,
      required final String defaultLocale}) = _$TaleLocalizationImpl;
  const _TaleLocalization._() : super._();

  factory _TaleLocalization.fromJson(Map<String, dynamic> json) =
      _$TaleLocalizationImpl.fromJson;

  @override
  String get id;
  @override
  String get taleId;
  @override
  Map<String, Map<String, String>> get translations;
  @override
  String get defaultLocale;

  /// Create a copy of TaleLocalization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleLocalizationImplCopyWith<_$TaleLocalizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

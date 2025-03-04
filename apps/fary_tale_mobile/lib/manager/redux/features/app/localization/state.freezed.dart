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
mixin _$LocalizationState {
  StateResult get status => throw _privateConstructorUsedError;
  String get locale =>
      throw _privateConstructorUsedError; //todo: change it to handle hashcode
  Map<String, String> get translations => throw _privateConstructorUsedError;
  int get localeVersion => throw _privateConstructorUsedError;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalizationStateCopyWith<LocalizationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) then) =
      _$LocalizationStateCopyWithImpl<$Res, LocalizationState>;
  @useResult
  $Res call(
      {StateResult status,
      String locale,
      Map<String, String> translations,
      int localeVersion});

  $StateResultCopyWith<$Res> get status;
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res, $Val extends LocalizationState>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? locale = null,
    Object? translations = null,
    Object? localeVersion = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      translations: null == translations
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      localeVersion: null == localeVersion
          ? _value.localeVersion
          : localeVersion // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get status {
    return $StateResultCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppLocalizationStateImplCopyWith<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  factory _$$AppLocalizationStateImplCopyWith(_$AppLocalizationStateImpl value,
          $Res Function(_$AppLocalizationStateImpl) then) =
      __$$AppLocalizationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StateResult status,
      String locale,
      Map<String, String> translations,
      int localeVersion});

  @override
  $StateResultCopyWith<$Res> get status;
}

/// @nodoc
class __$$AppLocalizationStateImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$AppLocalizationStateImpl>
    implements _$$AppLocalizationStateImplCopyWith<$Res> {
  __$$AppLocalizationStateImplCopyWithImpl(_$AppLocalizationStateImpl _value,
      $Res Function(_$AppLocalizationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? locale = null,
    Object? translations = null,
    Object? localeVersion = null,
  }) {
    return _then(_$AppLocalizationStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      translations: null == translations
          ? _value._translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      localeVersion: null == localeVersion
          ? _value.localeVersion
          : localeVersion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AppLocalizationStateImpl implements _AppLocalizationState {
  const _$AppLocalizationStateImpl(
      {required this.status,
      required this.locale,
      required final Map<String, String> translations,
      required this.localeVersion})
      : _translations = translations;

  @override
  final StateResult status;
  @override
  final String locale;
//todo: change it to handle hashcode
  final Map<String, String> _translations;
//todo: change it to handle hashcode
  @override
  Map<String, String> get translations {
    if (_translations is EqualUnmodifiableMapView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_translations);
  }

  @override
  final int localeVersion;

  @override
  String toString() {
    return 'LocalizationState(status: $status, locale: $locale, translations: $translations, localeVersion: $localeVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLocalizationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality()
                .equals(other._translations, _translations) &&
            (identical(other.localeVersion, localeVersion) ||
                other.localeVersion == localeVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, locale,
      const DeepCollectionEquality().hash(_translations), localeVersion);

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppLocalizationStateImplCopyWith<_$AppLocalizationStateImpl>
      get copyWith =>
          __$$AppLocalizationStateImplCopyWithImpl<_$AppLocalizationStateImpl>(
              this, _$identity);
}

abstract class _AppLocalizationState implements LocalizationState {
  const factory _AppLocalizationState(
      {required final StateResult status,
      required final String locale,
      required final Map<String, String> translations,
      required final int localeVersion}) = _$AppLocalizationStateImpl;

  @override
  StateResult get status;
  @override
  String get locale; //todo: change it to handle hashcode
  @override
  Map<String, String> get translations;
  @override
  int get localeVersion;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppLocalizationStateImplCopyWith<_$AppLocalizationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
